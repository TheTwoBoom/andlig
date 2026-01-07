extends Control


func _on_scanner_added_to_list() -> void:
	%AliveLabel.text = "People Alive: " + str(9-%Scanner.dead.size()) + "/9"
	for id in %Scanner.dead:
		toggle_container(id)

func toggle_container(id):
	var panel: PanelContainer = get_node_or_null("%PanelContainer" + str(id))
	var new_theme = preload("res://assets/panel_designs/dead_theme.tres")
	panel.theme = new_theme
