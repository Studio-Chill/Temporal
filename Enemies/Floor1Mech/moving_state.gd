extends State

# Export variables
@export var enemy: CharacterBody2D
@export var enemy_sprite: Sprite2D
@export var movement_speed: float
@export var wall_check_1: RayCast2D
@export var wall_check_2: RayCast2D

# Rotatable hitboxes contains enemy hitbox, collision, attack area, etc
# Stored in a Node2D so they all be rotated at once
@export var rotatable_hitboxes: Node2D

# Used for rotating sprite
var current_rotation: int = 0
var rotate: bool = false
var rotation_speed: int = 3

# Direction the spider is moving in
var direction = Vector2.RIGHT

func Update(_delta) -> void:
	
	# If the smaller wallcheck collides, turn spider by -90 degrees as well as direction
	if wall_check_1.is_colliding():
		
		# Disable wallcheck until spider has turned
		wall_check_1.enabled = false
		
		direction = direction.rotated(deg_to_rad(-90))
		wall_check_1.rotate(deg_to_rad(-90))
		wall_check_2.rotate(deg_to_rad(-90))
		rotatable_hitboxes.rotate(deg_to_rad(-90))
	
	# If the bigger wallcheck collides, turn the sprite
	if wall_check_2.is_colliding():
		rotate = true
	
	if rotate:
		
		# Turning sprite by rotation speed
		current_rotation -= rotation_speed
		enemy_sprite.rotation -= deg_to_rad(rotation_speed)
	
	# On reaching -90 degrees, stop turning and enable smaller wallcheck 
	if current_rotation == -90:
		wall_check_1.enabled = true
		current_rotation = 0
		rotate = false

func Physics_Update(_delta) -> void:
	enemy.velocity = direction * movement_speed
	enemy.move_and_slide()

# If player enters attack area, transition to attacking state
func _on_attack_area_body_entered(_body: Node2D) -> void:
	Transitioned.emit(self, "shooting")
