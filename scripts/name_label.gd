extends Label

var label_active
var playing

func _ready() -> void:
	label_active = false
	playing = false
	
func _on_mouse_entered() -> void:
	label_active = true
	add_theme_font_size_override("font_size", 65)

func _on_mouse_exited() -> void:
	label_active = false
	add_theme_font_size_override("font_size", 60)

func _input(event: InputEvent) -> void:
	if event.is_action_pressed("click") and label_active and not playing:
		playing = true
		$SoundPlayer.play()
		add_theme_color_override("font_color", Color(0.875, 0.878, 0.667, 1.0))
		rotation = PI / 100
		await get_tree().create_timer(0.05).timeout
		add_theme_color_override("font_color", Color(0.875, 0.569, 0.667, 1.0))
		rotation = 0
		await get_tree().create_timer(0.05).timeout
		add_theme_color_override("font_color", Color(0.659, 0.878, 0.667, 1.0))
		rotation = -PI / 100
		await get_tree().create_timer(0.05).timeout
		remove_theme_color_override("font_color")
		rotation = 0
		playing = false
