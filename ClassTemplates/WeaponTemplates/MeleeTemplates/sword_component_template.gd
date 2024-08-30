extends Node2D
class_name Sword_Component

@export var damage:  float
@export var knockback: float
@export var stun: int

func hit_enemy(area) -> void:
	if area.has_method("hit"):
		area.hit(damage, global_position, knockback, stun)
