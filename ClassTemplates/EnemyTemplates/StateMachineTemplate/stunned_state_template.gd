extends State
class_name StunnedState

@export var enemy : CharacterBody2D
@export var stunned_time : Timer

signal stun_ended

# Stop enemy and start stun timer
func Enter() -> void:
	enemy.velocity = Vector2(0, 0)
	stunned_time.start()

# On timeout, transition into pursue state
func _on_timer_timeout() -> void:
	stun_ended.emit()
