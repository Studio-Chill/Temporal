extends CharacterBody2D
class_name Player

# Variables for jumping 
@export var jump_height : float = 100.0
@export var jump_time_to_peak : float = 0.6
@export var jump_time_to_descent : float = 0.5
@onready var jump_velocity : float = ((2.0 * jump_height) / jump_time_to_peak) * -1.0
@onready var jump_gravity : float = ((-2.0 * jump_height) / (jump_time_to_peak * jump_time_to_peak)) * -1.0
@onready var fall_gravity : float = ((-2.0 * jump_height) / (jump_time_to_descent * jump_time_to_descent)) * -1.0

# Reference nodes
@onready var sprite_2d : Sprite2D = $Sprite2D
@onready var roll_cooldown : Timer = $Timers/RollCooldown
@onready var roll_timer : Timer = $Timers/RollTimer
@onready var player_collision : CollisionShape2D = $CollisionShape2D

# Jump/roll buffer and coyote time frames
@export var jump_buffer_time : int = 15
@export var coyote_time : int = 20
@export var roll_buffer_time : int = 20
var jump_buffer_counter : int = 0
var coyote_counter : int = 0
var roll_buffer_counter : int = 0

# Friction and air friction
const friction : float = 0.5
const air_friction : float = 0.2
const maximum_falling_velocity : float = 400.0
var previous_velocity : Vector2

# Variables for movement
@export var max_speed : float = 200.0
@export var roll_speed : float = 400.0
@export var acceleration : float = 50.0

# Bool variables
var can_roll : bool = true
var player_direction : bool = true
var rolling : bool = false

# Player health
@export var player_health: int

# Healthbar
@export var player_healthbar: CanvasLayer

func _physics_process(delta: float) -> void:
	roll()
	moving()
	jumping(delta)
	move_and_slide()
	platform_check()
	
	# Getting previous velocity for air friction
	previous_velocity = velocity
	
	player_healthbar.init_health(player_health)

func roll() -> void:
	# Roll buffer
	if Input.is_action_pressed("roll"):
		roll_buffer_counter = roll_buffer_time
	
	if (roll_buffer_counter > 0):
		roll_buffer_counter -= 1
	
	if (roll_buffer_counter > 0) and can_roll:
		# Change bools to indicate player is rolling and start timers
		can_roll = false
		rolling = true
		roll_timer.start()
		roll_cooldown.start()
		
		# Setting player's velocity to the roll speed
		if player_direction:
			velocity.x = roll_speed
		else:
			velocity.x = -roll_speed

func get_multiply_gravity() -> float:
	# Reduce gravity if roll is active
	if rolling:
		return fall_gravity / 4
	
	else:
		# Returns normal gravity if player is jumping
		if (velocity.y < 0.0):
			return jump_gravity
		
		# Returns greater gravity if player is falling
		else:
			return fall_gravity

func moving() -> void:
	
	# Flip the player if mouse is on left side of screen
	if (get_global_mouse_position().x > global_position.x):
		sprite_2d.flip_h = false
	else:
		sprite_2d.flip_h = true
	
	# Movement and flipping sprite left/right
	if Input.is_action_pressed("right"):
		if not rolling:
			velocity.x += acceleration
			player_direction = true
	elif Input.is_action_pressed("left"):
		if not rolling:
			velocity.x -= acceleration
			player_direction = false
	
	# Returning velocity.x to 0 if no keys are pressed and not rolling
	else:
		if not rolling:
			velocity.x = lerp(velocity.x, 0.0, friction)
	
	# Capping velocity.x to maximum_speed if player is not rolling
	if (velocity.x > max_speed) or (velocity.x < -max_speed):
		if not rolling:
			velocity.x = clamp(velocity.x, -max_speed, max_speed)

func jumping(delta) -> void:
	# Applying gravity
	if not is_on_floor():
		velocity.y += get_multiply_gravity() * delta
		
		# Applying air friction if player is not rolling
		if not rolling:
			velocity.x = lerp(previous_velocity.x, velocity.x, air_friction)
	
	# Setting maximum falling gravity
	if (velocity.y >= maximum_falling_velocity):
		velocity.y = maximum_falling_velocity
	
	# Coyote time
	if is_on_floor():
		coyote_counter = coyote_time
	if not is_on_floor():
		if coyote_counter > 0:
			coyote_counter -= 1
	
	# Allowing smaller jumps with smaller presses
	if Input.is_action_just_released("up") and velocity.y < 0:
			velocity.y = -jump_velocity / 10
	
	# Jump buffer
	if Input.is_action_just_pressed("up"):
		jump_buffer_counter = jump_buffer_time
	if (jump_buffer_counter > 0):
		jump_buffer_counter -= 1
	
	# Jumping
	if (jump_buffer_counter > 0) and (coyote_counter > 0):
		velocity.y = jump_velocity
		jump_buffer_counter = 0

func platform_check() -> void:
	if Input.is_action_pressed("down"):
		set_collision_mask_value(7, false)
	else:
		set_collision_mask_value(7, true)

func player_hit(damage) -> void:
	player_health -= damage
	player_healthbar.damage(damage)

# Roll cooldown and time of rolling
func _on_roll_cooldown_timeout() -> void:
	can_roll = true

func _on_roll_timer_timeout() -> void:
	rolling = false
