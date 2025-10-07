extends CanvasLayer

signal stop
signal play

func _ready() -> void:
	update_score(Vector2i(0,0))
	$MenuButton.hide()
	$ExitButton.hide()

func _on_stop_button_pressed() -> void:
	$ClickPlayer.play()
	if $ExitButton.is_visible_in_tree():
		$ExitButton.hide()
		$MenuButton.hide()
		$StopButton.text = "Stop"
		play.emit()
	else:
		$ExitButton.show()
		$MenuButton.show()
		$StopButton.text = "Continue"
		stop.emit()  

func _on_exit_button_pressed() -> void:
	$ClickPlayer.play()
	await get_tree().create_timer(0.1).timeout
	get_tree().quit()

func update_score(score: Vector2i):
	$ScoreLabel.text = "Score: " + str(score.y) + "/" + str(score.x)

func _on_menu_button_pressed() -> void:
	$ClickPlayer.play()
	await get_tree().create_timer(0.1).timeout
	get_tree().change_scene_to_file("res://scenes/menu.tscn")
