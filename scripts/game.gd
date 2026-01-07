extends Control


func _on_scanner_added_to_list() -> void:
	%AliveLabel.text = "People Alive: " + str(9-%Scanner.dead.size()) + "/9"
	for id in %Scanner.dead:
		toggle_container(id)

func toggle_container(id):
	var panel: PanelContainer = get_node("%ShadowContainer" + str(id))
	var stylebox = load("res://assets/panel_designs/dead.tres")
	panel.theme.set_stylebox("panel", "StyleBoxFlat", stylebox)
