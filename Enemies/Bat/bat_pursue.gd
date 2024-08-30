extends State

@export var player : CharacterBody2D
@export var enemy: CharacterBody2D
@export var enemy_sprite: Sprite2D
@export var movement_speed : int
@export var navigation_agent_2d : NavigationAgent2D
@export var steer_force: float

var current_agent_position : Vector2
var next_path_position : Vector2
var knockback : Vector2

# Get player
func Enter() -> void:
	player = get_tree().get_nodes_in_group("Player")[0]

# Using navigation agent to get next path position
func Update(_delta : float) -> void:
	if player:
		navigation_agent_2d.target_position = player.global_position
	
	current_agent_position = enemy.global_position
	next_path_position = navigation_agent_2d.get_next_path_position()


func Physics_Update(_delta : float) -> void:
	
	# Flipping enemy in accordance to velocity
	if (enemy.velocity.x > 0):
		enemy_sprite.flip_h = false
	elif (enemy.velocity.x < 0):
		enemy_sprite.flip_h = true
	
	# Make enemy move towards player
	enemy.velocity = steer(next_path_position)
	enemy.move_and_slide()

# Steering function for more natural movement behavior
func steer(target : Vector2) -> Vector2:
	var desired_velocity: Vector2 = (target - current_agent_position).normalized() * movement_speed
	var steer_velocity: Vector2 = desired_velocity - enemy.velocity
	var target_velocity: Vector2 = enemy.velocity + (steer_velocity * steer_force)
	return target_velocity
