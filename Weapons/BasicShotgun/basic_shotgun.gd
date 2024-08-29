extends Bullet_Weapon

# Preload shotgun pellet scene
func _init() -> void:
	bullet = preload("res://Weapons/BasicShotgun/basic_shotgun_pellet.tscn")

func shoot() -> void:
	# If player is holding weapon and shooting is not on cooldown
	if holding_weapon == true and can_shoot == true:
		# Create bullet instance, and set its rotation and spawn location
		for i in range(4):
			var bullet_instance = bullet.instantiate()
			bullet_instance.rotation = rotation
			bullet_instance.global_position = spawn_position.global_position
			add_child(bullet_instance)
		
		# Start cooldown until next shot
		can_shoot = false
		bullet_cooldown.start()
