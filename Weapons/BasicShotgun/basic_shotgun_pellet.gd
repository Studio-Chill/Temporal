extends Bullet

@export var random_angle: int
var calculated_angle: float
@export var standard_deviation: float

func _ready() -> void:
	set_as_top_level(true)
	calculated_angle = random_spread()

func _process(delta: float) -> void:
	position += (velocity * bullet_speed).rotated(rotation + calculated_angle) * delta

func random_spread() -> float:
	var deviation = randfn(0, standard_deviation)
	random_angle = randi_range(-random_angle, random_angle)
	return deg_to_rad(random_angle * deviation)
