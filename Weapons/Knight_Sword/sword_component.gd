extends Sword_Component

func _on_swing_area_entered(area: Area2D) -> void:
	print("hit1")
	hit_enemy(area)

func _on_swing_2_area_entered(area: Area2D) -> void:
	print("hit2")
	hit_enemy(area)
