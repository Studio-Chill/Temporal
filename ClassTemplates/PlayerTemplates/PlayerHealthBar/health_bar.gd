extends ProgressBar

# Making health a setter so it's called every time it gets changed (damaged)
var health: float

func _on_player_health_bar_initalize_health(player_health) -> void:
	max_value = player_health
	value = player_health
	health = player_health

func _on_player_health_bar_damage_player(damage) -> void:
	if damage > 0:
		value = health - damage
		print(value)
	health -= damage
