extends Node

func _input(event: InputEvent) -> void:
	if event.keycode:
		print(event.keycode)
