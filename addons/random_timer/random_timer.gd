@tool
class_name RandomTimer extends Timer


@export_range(0.001, 4096, 0.001, "exp", "suffix:s") var min_wait_time: float = 1.0
@export_range(0.001, 4096, 0.001, "exp", "suffix:s") var max_wait_time: float = 2.0

var _rng := RandomNumberGenerator.new()


func _ready() -> void:
	_rng.randomize()
	
	if autostart and not Engine.is_editor_hint():
		start_random()


func start_random() -> void:
	super.start(_rng.randf_range(min_wait_time, max_wait_time))


func _on_timeout() -> void:
	if not one_shot:
		start_random()
