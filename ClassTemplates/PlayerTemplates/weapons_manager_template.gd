extends Node2D

# Create an array to store the player weapons
var weapons_array : Array

# Current weapon held
var current_weapon: Node2D
var weapon_position: int

func _ready() -> void:
	
	# Get all weapons under node
	get_weapons()
	
	# Set current weapon to initial weapon
	current_weapon = weapons_array[0]
	weapon_position = 0
	
	# Call hold weapon function on current weapon
	current_weapon.hold_weapon()

# Set current weapon as the weapon position index in array
# Call shoot and swap weapon functions
func _process(_delta: float) -> void:
	shoot()
	swap_weapon()
	
	current_weapon = weapons_array[weapon_position]
	current_weapon.hold_weapon()

# Gets all children of the weapons node and store into array
# If weapon is not current weapon, stow it
func get_weapons() -> void:
	for i in get_children():
		weapons_array.append(i)
		if i != current_weapon:
			i.stow_weapon()

func shoot() -> void:
	if Input.is_action_pressed("shoot"):
		current_weapon.shoot()

func swap_weapon() -> void:
	if Input.is_action_just_pressed("debug_key"):
		current_weapon.stow_weapon()
		
		# Increase weapon position by 1, unless it is equal to the size of array
		if weapon_position < len(weapons_array) - 1:
			weapon_position += 1
		else:
			weapon_position = 0
