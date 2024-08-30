extends StateMachine

# Go to pursue state after stun
func on_stunned_state_stun_ended() -> void:
	
	var new_state = states.get("pursue")
	if !new_state:
		return
	
	if current_state:
		current_state.Exit()
	
	new_state.Enter()
	current_state = new_state

# If players enters the hit area, emit damage and get stunned
func _on_hitbox_body_entered(_body: Node2D) -> void:
	print("Hit player")
	
	if current_state:
		current_state.Exit()
	
	var new_state = states.get("stunned")
	
	new_state.Enter()
	current_state = new_state
