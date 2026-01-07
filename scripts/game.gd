extends Control

var killer = null

func _ready() -> void:
	killer = %Scanner.ALLOWED_INPUTS.pick_random()
	var label = get_node_or_null("%PanelContainer" + str(killer) + "/Label") as Label
	var new_theme = preload("res://assets/font/big_font_red.tres")
	label.theme = new_theme

func _on_scanner_added_to_list() -> void:
	%AliveLabel.text = "People Alive: " + str(9-%Scanner.dead.size()) + "/9"
	for id in %Scanner.dead:
		toggle_container(id)

func toggle_container(id):
	var panel: PanelContainer = get_node_or_null("%PanelContainer" + str(id))
	var new_theme = preload("res://assets/panel_designs/dead_theme.tres")
	panel.theme = new_theme
