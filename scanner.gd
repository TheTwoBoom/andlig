extends Node

var dead = []
var last_press = ""

func _input(event):
	if event is InputEventKey:
		var keycode = DisplayServer.keyboard_get_keycode_from_physical(event.physical_keycode)
		last_press = keycode
	
		if str(keycode) == "Enter" and not last_press in dead :
			dead.append(last_press)
			print(str(dead) + "  " + last_press)
			
		keycode = OS.get_keycode_string(keycode)
