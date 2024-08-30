extends State

@export var enemy : CharacterBody2D
@export var enemy_sprite : Sprite2D
@export var detection_area_horizontal : Area2D
@export var moving_timer : RandomTimer
@export var state_machine : Node
@export var pursue_state : Node
@export var movement_speed : int
var move_direction : Vector2

# Determine a random direction to go to, except up and down
func Enter() -> void:
	moving_timer.start_random()
	Randomize_Movement()

# Flipping sprite and detection areas in accordance to velocity
func Update(_delta: float) -> void:
	if enemy.velocity.x > 0:
		enemy_sprite.flip_h = false
		detection_area_horizontal.scale = Vector2(1, 1)
		detection_area_horizontal.position = Vector2(0, 0)
	else:
		enemy_sprite.flip_h = true
		detection_area_horizontal.scale = Vector2(-1, 1)
		detection_area_horizontal.position = Vector2(-3, 0)

func Physics_Update(_delta: float) -> void:
	enemy.move_and_slide()
	if enemy:
		enemy.velocity = (movement_speed * move_direction)

func Randomize_Movement() -> void:
	move_direction = Vector2(Random_Direction_X(), Random_Direction_Y()).normalized()

# Randomize direction
func Random_Direction_X() -> int:
	return randi_range(0, 1) * 2 - 1

func Random_Direction_Y() -> int:
	return randi_range(0, 1)

# Upon hitting wall/ceiling, multiply move direction's x/y by -1 to reverse direction
func _on_detection_area_h_body_entered(_body: Node2D) -> void:
	move_direction.x *= -1

func _on_detection_area_v_body_entered(_body: Node2D) -> void:
	move_direction.y *= -1

func _on_moving_timer_timeout() -> void:
	Transitioned.emit(self, "stationary")

func _on_pursue_area_body_entered(_body: Node2D) -> void:
	if state_machine.current_state != pursue_state:
		Transitioned.emit(self, "pursue")
