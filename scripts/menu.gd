extends CanvasLayer

func _input(event: InputEvent) -> void:
	if event.is_action_released("click") and not $NameLabel.label_active:
		$ClickPlayer.play()

func _on_exit_button_pressed() -> void:
	await get_tree().create_timer(0.1).timeout
	get_tree().quit()

func _on_pvp_button_pressed() -> void:
	await get_tree().create_timer(0.1).timeout
	GlobalInfo.player2 = "player2"
	GlobalInfo.player1 = "player1"
	get_tree().change_scene_to_file("res://scenes/field.tscn")

func _on_pvc_button_pressed() -> void:
	await get_tree().create_timer(0.1).timeout
	GlobalInfo.player2 = "pc2"
	GlobalInfo.player1 = "player1"
	get_tree().change_scene_to_file("res://scenes/field.tscn")

func _on_cvc_button_pressed() -> void:
	await get_tree().create_timer(0.1).timeout
	GlobalInfo.player2 = "pc2"
	GlobalInfo.player1 = "pc1"
	get_tree().change_scene_to_file("res://scenes/field.tscn")

func _on_settings_button_pressed() -> void:
	await get_tree().create_timer(0.1).timeout
	get_tree().change_scene_to_file("res://scenes/settings.tscn")
