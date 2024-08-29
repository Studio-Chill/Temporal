extends Node2D
class_name Bullet_Weapon

# Node variables
@onready var bullet : PackedScene
@export var player : CharacterBody2D
@export var spawn_position : Marker2D
@export var bullet_cooldown : Timer
@export var weapon_sprite: Sprite2D

# Player position and bool for shooting cooldown
var player_position : Vector2
var can_shoot : bool = true

# Bool to store if player is holding weapon
var holding_weapon: bool = false

func _process(_delta) -> void:
	flip_weapon()
	look_at(get_global_mouse_position())

func flip_weapon() -> void:
	player_position.x = player.global_position.x
	
	# Flip the weapon if mouse is on left side of screen
	if (get_global_mouse_position().x > player_position.x):
		scale = Vector2(1, 1)
	else:
		scale = Vector2(1, -1)

func shoot() -> void:
	# If player is holding weapon and shooting is not on cooldown
	if holding_weapon == true and can_shoot == true:
		# Create bullet instance, and set its rotation and spawn location
		var bullet_instance = bullet.instantiate()
		bullet_instance.rotation = rotation
		bullet_instance.global_position = spawn_position.global_position
		add_child(bullet_instance)
		
		# Start cooldown until next shot
		can_shoot = false
		bullet_cooldown.start()

# Functions to be called by player upon swapping weapons
func hold_weapon() -> void:
	holding_weapon = true
	weapon_sprite.visible = true

func stow_weapon() -> void:
	holding_weapon = false
	weapon_sprite.visible = false

# Timer for shooting
func _on_timer_timeout() -> void:
	can_shoot = true
