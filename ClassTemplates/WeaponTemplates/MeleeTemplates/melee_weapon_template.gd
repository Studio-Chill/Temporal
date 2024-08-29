extends Node2D
class_name Melee_Weapon

# Node variables
@export var player: CharacterBody2D
@export var weapon_sprite: Sprite2D
@export var animation_player: AnimationPlayer

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
	animation_player.play("Swing")

func hold_weapon() -> void:
	holding_weapon = true
	weapon_sprite.visible = true

func stow_weapon() -> void:
	holding_weapon = false
	weapon_sprite.visible = false

func _on_timer_timeout() -> void:
	can_shoot = true
