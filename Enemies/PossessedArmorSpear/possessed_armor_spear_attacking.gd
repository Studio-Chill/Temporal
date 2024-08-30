extends State

func Enter() -> void:
	$Timer.start()
	print("Hit player, possessed armor")

func _on_timer_timeout() -> void:
	Transitioned.emit(self, "pursue")
