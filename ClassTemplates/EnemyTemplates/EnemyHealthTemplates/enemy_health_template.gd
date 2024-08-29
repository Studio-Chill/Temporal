extends Node2D
class_name EnemyHealthComponent

@export var enemy : CharacterBody2D

# Store all information of enemy
@export var enemy_health : float
@export var knockback_resistance : float
@export var current_stun: int
@export var stun_capacity: int
@export var stun_resistance: int

# For applying knockback
var knockback_direction : Vector2

# Get healthbar and hitbox
@export var health_bar: ProgressBar
@export var hitbox: Area2D

# For stun
signal stun_activate

func _ready() -> void:
	hitbox.enemy_hit.connect(on_hitbox_enemy_hit)
	health_bar.init_health(enemy_health)

func _process(_delta: float) -> void:
	
	# All enemies have a stun capacity, and if the stun goes over it, 
	# the enemy will be stunned
	if current_stun >= stun_capacity:
		
		# Emit the stun signal and reset stun
		stun_activate.emit()
		current_stun = 0

# Enemy hitbox conveys bullet info upon hit
func on_hitbox_enemy_hit(damage: float, bullet_position: Vector2, knockback: float, stun: int) -> void:
	
	# Get direction of knockback multiply it by knockback subtracted by resistance
	knockback_direction = bullet_position.direction_to(enemy.global_position)
	enemy.velocity -= knockback_direction * (knockback - knockback_resistance)
	
	# Subtract health and update healthbar
	enemy_health -= damage
	health_bar.health = enemy_health
	
	# Increase stun by bullet stun subtracted by resistance
	current_stun += (stun - stun_resistance)
