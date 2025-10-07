extends CanvasLayer

func _input(event: InputEvent) -> void:
	if event.is_action_released("click"):
		$ClickPlayer.play()

func _ready() -> void:
	copy_data()

func copy_data() -> void:
	$UI/PlatformSpeedSlider.value = GlobalInfo.platform_speed
	$UI/SpeedIncreaseSlider.value = GlobalInfo.speed_increase
	$UI/StartSpeedSlider.value = GlobalInfo.start_speed
	$UI/MaxSpeedSlider.value = GlobalInfo.max_speed
	$UI/AiMultilierSlider.value = GlobalInfo.ai_mult

func _on_menu_button_pressed() -> void:
	await get_tree().create_timer(0.1).timeout
	get_tree().change_scene_to_file("res://scenes/menu.tscn")

func _on_save_button_pressed() -> void:
	GlobalInfo.platform_speed = $UI/PlatformSpeedSlider.value
	GlobalInfo.speed_increase = $UI/SpeedIncreaseSlider.value
	GlobalInfo.start_speed = $UI/StartSpeedSlider.value
	GlobalInfo.max_speed = $UI/MaxSpeedSlider.value
	GlobalInfo.ai_mult = $UI/AiMultilierSlider.value
	GlobalInfo.save_data()

func _on_reset_button_pressed() -> void:
	GlobalInfo.reset()
	GlobalInfo.save_data()
	copy_data()
