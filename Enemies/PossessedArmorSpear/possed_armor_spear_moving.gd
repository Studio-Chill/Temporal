extends State

@export var enemy : CharacterBody2D
@export var enemy_sprite : Sprite2D
@export var move_direction : int
@export var movement_speed : int
@export var left_ledge_check : RayCast2D
@export var right_ledge_check : RayCast2D
@export var left_wall_check : RayCast2D
@export var right_wall_check : RayCast2D
@export var falling_check: RayCast2D
@export var enemy_areas: Node2D

const gravity: int = 1000
const maximum_falling_velocity: int = 2000

func Update(_delta: float) -> void:
	if enemy.velocity.x > 0:
		enemy_sprite.flip_h = false
		enemy_areas.scale = Vector2(1, 1)
	else:
		enemy_sprite.flip_h = true
		enemy_areas.scale = Vector2(-1, 1)

# Just moving enemy left and right on a platform, and turning around
# if enemy hits a ledge/wall
func Physics_Update(delta: float) -> void:
	enemy.velocity.y += gravity * delta
	
	if (enemy.velocity.y >= maximum_falling_velocity):
		enemy.velocity.y = maximum_falling_velocity
	
	if enemy:
		enemy.velocity.x = (movement_speed * move_direction)
	
	if falling_check.is_colliding() != false:
		if enemy.velocity.x < 0:
			if left_ledge_check.is_colliding() == false or left_wall_check.is_colliding() == true:
				move_direction *= -1
		elif enemy.velocity.x > 0:
			if right_ledge_check.is_colliding() == false or right_wall_check.is_colliding() == true:
				move_direction *= -1
	
	enemy.move_and_slide()
