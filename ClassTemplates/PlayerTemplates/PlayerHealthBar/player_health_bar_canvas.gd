extends CanvasLayer

signal initalize_health
signal damage_player

func init_health(player_health):
	initalize_health.emit(player_health)

func damage(damage):
	damage_player.emit(damage)
