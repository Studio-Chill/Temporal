extends ProgressBar
class_name EnemyHealthBar

# Damage bar
@export var damage_bar: ProgressBar
@export var damage_timer: Timer

# Making health a setter so it's called every time it gets changed (damaged)
var health: float: set = set_health

# Subtracting health and starting damage timer if hit
# Damage bar remains for a bit, displaying some white for damage value
func set_health(new_health):
	var previous_health: float = health
	health = min(max_value, new_health)
	value = health
	
	if health < previous_health:
		damage_timer.start()
	else:
		damage_bar.value = health

# Initializing and setting values of health and damage bar
func init_health(enemy_health: float) -> void:
	max_value = enemy_health
	health = enemy_health
	value = health
	damage_bar.max_value = health
	damage_bar.value = health

# Set damage bar equal to health bar on timeout
func _on_damage_timer_timeout() -> void:
	damage_bar.value = health
