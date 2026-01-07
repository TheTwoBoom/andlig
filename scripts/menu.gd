extends Control

var id_counter = 0

func _on_start_game_button_pressed() -> void:
	%PlayContainer.visible = true

func _on_credits_button_pressed() -> void:
	get_tree().change_scene_to_file("res://scenes/credits.tscn")

func _on_exit_button_pressed() -> void:
	get_tree().quit()

func _on_play_button_pressed() -> void:
	if PlayerManager.players.size() > 2:
		get_tree().change_scene_to_file("res://scenes/game.tscn")
	else:
		%AddMorePlayers.visible = true

func _on_add_player_button_pressed() -> void:
	if str(%LineEdit.text).strip_edges().is_empty():
		return
	add_player()
	
func _input(event: InputEvent) -> void:
	if str(%LineEdit.text).strip_edges().is_empty():
		return
		
	if event.is_action_pressed("ui_accept"):
		add_player()
	
func add_player():
	if %GridContainer.get_child_count() < 9:
		PlayerManager.players.append(%LineEdit.text)
		var label: Label = load("res://assets/menu_player_label.tscn").instantiate()

		id_counter += 1
		label.text = str(id_counter) + ": " + %LineEdit.text
		%GridContainer.add_child(label)
		%LineEdit.text = ""
