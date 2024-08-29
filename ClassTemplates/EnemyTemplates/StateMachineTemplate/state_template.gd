extends Node
class_name State

# Signal for transitioning between states
@warning_ignore("unused_signal")
signal Transitioned 

# Function called upon entering state
func Enter() -> void:
	pass

# Function called upon leaving state
func Exit() -> void:
	pass

# Function called by StateMachine to act as _update()
func Update(_delta: float) -> void:
	pass

# Function called by StateMachine to act as _physics_update()
func Physics_Update(_delta: float) -> void:
	pass
