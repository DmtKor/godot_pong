extends Node

var player2 = "player2"
var player1 = "player1"
var platform_speed = 600.0
var speed_increase = 25.0
var start_speed = 350.0
var max_speed = 900.0
var ai_mult = 0.3

func _ready() -> void:
	load_data()

func reset() -> void:
	platform_speed = 600.0
	speed_increase = 25.0
	start_speed = 350.0
	max_speed = 900.0
	ai_mult = 0.3

func load_data() -> void:
	if not FileAccess.file_exists("user://pong.save"):
		reset()
		save_data()
		return
	var save_file = FileAccess.open("user://pong.save", FileAccess.READ)
	var json_string = save_file.get_line()
	var json = JSON.new()
	var parse_result = json.parse(json_string)
	if not parse_result == OK:
			print("JSON Parse Error: ", json.get_error_message(), " in ", json_string, " at line ", json.get_error_line())
			reset()
			save_data()
			return
	var data = json.data
	platform_speed = data["platform_speed"]
	speed_increase = data["speed_increase"]
	start_speed = data["start_speed"]
	max_speed = data["max_speed"]
	ai_mult = data["ai_mult"]
	
func save_data() -> void:
	var save_dict = {
		"platform_speed": platform_speed,
		"speed_increase": speed_increase,
		"start_speed": start_speed,
		"max_speed": max_speed,
		"ai_mult": ai_mult
	}
	var save_file = FileAccess.open("user://pong.save", FileAccess.WRITE)
	var json_string = JSON.stringify(save_dict)
	save_file.store_line(json_string)
