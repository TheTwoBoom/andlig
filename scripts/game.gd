extends Control

var people_killed = 0

func _ready() -> void:
	var id_counter = 0
	for player in PlayerManager.players:
		id_counter += 1
		var container: PanelContainer = load("res://assets/player_container.tscn").instantiate()
		container.name = "PanelContainer" + player
		%PlayerGridContainer.add_child(container)
		
		var shadow_container: PanelContainer = load("res://assets/shadow_container.tscn").instantiate()
		shadow_container.name = "ShadowContainer" + player
		%ShadowGridContainer.add_child(shadow_container)
		
		container.find_child("NameLabel").text = player
		container.find_child("IDLabel").text = str(id_counter)
		
	PlayerManager.killer = PlayerManager.players.pick_random()
	var label = %PlayerGridContainer.get_node_or_null("PanelContainer" + str(PlayerManager.killer)).find_child("NameLabel") as Label
	var new_theme = preload("res://assets/font/big_font_red.tres")
	label.theme = new_theme
	%AliveLabel.text = "People Alive: " + str(%PlayerGridContainer.get_children().size()-people_killed) + "/" + str(%PlayerGridContainer.get_children().size())

func _on_scanner_added_to_list() -> void:
	people_killed += 1
	if people_killed+1 == %PlayerGridContainer.get_children().size():
		PlayerManager.reset()
		get_tree().change_scene_to_file("res://scenes/game_over.tscn")
	for child in %PlayerGridContainer.get_children():
		if child.find_child("NameLabel").text == PlayerManager.killer and child.find_child("IDLabel").text in $Scanner.dead:
			%PanelContainer.visible = true
	%AliveLabel.text = "People Alive: " + str(%PlayerGridContainer.get_children().size()-people_killed) + "/" + str(%PlayerGridContainer.get_children().size())
	for id in %Scanner.dead:
		toggle_container(id)

func toggle_container(id):
	var panel
	for child in %PlayerGridContainer.get_children():
		var child_id = int(child.find_child("IDLabel").text)
		if id == child_id:
			panel = child
			break
	if !panel:
		return
	var new_theme = preload("res://assets/panel_designs/dead_theme.tres")
	panel.theme = new_theme
