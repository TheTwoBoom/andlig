extends Control

var killer = null

func _ready() -> void:
	for player in PlayerManager.players:
		var container: PanelContainer = load("res://assets/player_container.tscn").instantiate()
		container.name = "PanelContainer" + player
		%PlayerGridContainer.add_child(container)
		
		var shadow_container: PanelContainer = load("res://assets/shadow_container.tscn").instantiate()
		shadow_container.name = "ShadowContainer" + player
		%ShadowGridContainer.add_child(shadow_container)
	
	killer = PlayerManager.players.pick_random()
	var label = %PlayerGridContainer.get_node_or_null("PanelContainer" + str(killer) + "/Label") as Label
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
