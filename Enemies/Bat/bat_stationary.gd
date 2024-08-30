extends State

@export var state_machine : Node
@export var pursue_state : Node
@export var bat : CharacterBody2D
@export var stationary_time : RandomTimer

# Stop the bat, and start a random timer
func Enter() -> void:
	bat.velocity = Vector2(0, 0)
	stationary_time.start_random()

# On timeout, transition into moving state
func _on_stationary_timer_timeout() -> void:
	Transitioned.emit(self, "moving")

# If player enteres detection area and current state is not pursue, start pursuing
func _on_pursue_area_body_entered(_body: Node2D) -> void:
	if state_machine.current_state != pursue_state:
		Transitioned.emit(self, "pursue")
