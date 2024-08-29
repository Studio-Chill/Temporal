extends StateMachine

# If player enters the attack area, transition to attacking state
func _on_attack_area_body_entered(_body: Node2D) -> void:
	
	if current_state:
		current_state.Exit()
	
	var new_state = states.get("attacking")
	
	new_state.Enter()
	current_state = new_state
