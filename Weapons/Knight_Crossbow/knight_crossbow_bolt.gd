extends Bullet

# Get arrow collision
@export var collision : CollisionPolygon2D 

# Upon hitting an enemy
func _on_area_entered(area: Area2D) -> void:
	
	# Disable collision, set speed to 0, and call hit method with info
	call_deferred("disable_collision")
	bullet_speed = 0
	if area.has_method("hit"):
		area.hit(damage, global_position, knockback, stun)
	
	# Store current position of arrow and add arrow to the hitbox it collides with
	var stored_position : Vector2 = global_position
	reparent.call_deferred(area)
	
	# Remove top level and set position again
	top_level = false
	global_position = stored_position

# Removing arrow if it exits screen
func _on_visible_on_screen_notifier_2d_screen_exited() -> void:
	queue_free()

# Function for disabling collision
func disable_collision() -> void:
	collision.disabled = true
