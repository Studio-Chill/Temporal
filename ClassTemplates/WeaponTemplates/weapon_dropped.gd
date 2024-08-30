extends Area2D

@export var uninteracted_sprite: Sprite2D
@export var interacted_sprite: Sprite2D

var fluctuating: bool = false
var up: bool = true

var fallen_position: Vector2

var tween: Tween = create_tween()

func _ready() -> void:
	interacted_sprite.visible = false

func _process(delta: float) -> void:
	if fluctuating == false:
		position.y += 2
	else:
		fluctate()

func fluctate() -> void:
	tween.tween_property(self, "position:y", Vector2(fallen_position.y, fallen_position.y - 10), 1)

func _on_body_entered(body: Node2D) -> void:
	if body.is_in_group("Player"):
		interacted_sprite.visible = true
	
	if body.is_in_group("Walls"):
		fluctuating = true
		
		fallen_position = global_position
		
		$Timer.start()

func _on_body_exited(body: Node2D) -> void:
	interacted_sprite.visible = false

func _on_timer_timeout() -> void:
	
	if up:
		up = false
	else:
		up = true
	
	$Timer.start()
