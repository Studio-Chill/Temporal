extends Node
class_name StateMachine

# Storing states using a dictionary
var states : Dictionary = {}

@export var initial_state : State
var current_state : State
var original_state: State

@export var health_component : Node2D
@export var stunned_state: State

func _ready() -> void:
	# Put children into dictionary and connect their transition signal
	for child in get_children():
		states[child.name.to_lower()] = child
		child.Transitioned.connect(on_child_transition)
	
	if initial_state:
		initial_state.Enter()
		current_state = initial_state
	
	# Connecting component and stunned state
	health_component.stun_activate.connect(on_health_component_stun_activate)
	stunned_state.stun_ended.connect(on_stunned_state_stun_ended)

# Updating current state every frame and physics frame
func _process(delta) -> void:
	if current_state:
		current_state.Update(delta)

func _physics_process(delta) -> void:
	if current_state:
		current_state.Physics_Update(delta)

# Transitioning states
func on_child_transition(state, new_state_name) -> void:
	if state != current_state:
		return
	
	var new_state = states.get(new_state_name.to_lower())
	if !new_state:
		return
	
	if current_state:
		current_state.Exit()
	
	new_state.Enter()
	current_state = new_state


# If enemy gets stunned, transition to stunned state
func on_health_component_stun_activate() -> void:
	
	original_state = current_state
	
	var new_state = states.get("stunned")
	if !new_state:
		return
	
	if current_state:
		current_state.Exit()
	
	new_state.Enter()
	current_state = new_state

# Return to state before stun
func on_stunned_state_stun_ended() -> void:
	
	var new_state = original_state
	if !new_state:
		return
	
	if current_state:
		current_state.Exit()
	
	new_state.Enter()
	current_state = new_state
