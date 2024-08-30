extends State

# Export variables
@export var spawn_location: Marker2D
@export var rotatable_hitboxes: Node2D

# Bullet scene
@onready var bullet_scene = preload("res://Enemies/Floor1Mech/floor_1_mech_spike.tscn")

func Enter() -> void:
	$Timer.start()
	call_deferred("splash_fire")

# Shoot 3 spikes at 30, 90, and 150 degrees
func splash_fire():
	
	# An array to store bullet instances
	var bullet_array: Array = [null, null, null]
	
	# Shooting bullet
	for i in range(3):
		bullet_array[i] = bullet_scene.instantiate()
		bullet_array[i].rotation = deg_to_rad(-60 * i - 30 + rad_to_deg(rotatable_hitboxes.rotation))
		bullet_array[i].global_position = spawn_location.global_position
		get_tree().get_root().add_child(bullet_array[i])

func _on_timer_timeout() -> void:
	Transitioned.emit(self, "moving")
