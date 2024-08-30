extends CharacterBody2D

const MAX_SPEED = 100
const MAX_FORCE = 0.1
@onready var target : CharacterBody2D = $"../Player"

func _physics_process(delta):
 velocity = steer(target.position)
 move_and_slide()

func steer(target : Vector2) -> Vector2:
 var helper= (target - get_position()).normalized() * MAX_SPEED 
 var desired_velocity = Vector2(helper.x, helper.y)
 var steer = desired_velocity - velocity
 var target_velocity = velocity + (steer * MAX_FORCE )
 return target_velocity

