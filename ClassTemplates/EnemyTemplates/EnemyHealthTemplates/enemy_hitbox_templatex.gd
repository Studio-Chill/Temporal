extends Area2D
class_name EnemyHitbox

# Emit signal to health component upon hit
signal enemy_hit

# Bullets will call hit function upon impact
# Hit function emits signal contains all information of bullet
func hit(damage: float, bullet_position: Vector2, knockback: float, stun: int) -> void:
	print("Enemy hit!")
	enemy_hit.emit(damage, bullet_position, knockback, stun)
