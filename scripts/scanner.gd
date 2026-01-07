extends Node

const ALLOWED_INPUTS = [1, 2, 3, 4, 5, 6, 7, 8, 9]

var dead = []
var last_press = ""

signal added_to_list

func _input(event):
	if event is InputEventKey and event.pressed and not event.echo:
		var keycode = DisplayServer.keyboard_get_keycode_from_physical(event.physical_keycode)
		var key_name = OS.get_keycode_string(keycode)

		if key_name == "Enter" and not int(last_press) in dead and int(last_press) in ALLOWED_INPUTS:
			for child in %PlayerGridContainer.get_children():
				if child.find_child("NameLabel") == PlayerManager.killer and child.find_child("IDLabel"):
					return
			dead.append(int(last_press))
			emit_signal("added_to_list")
		
		last_press = key_name
