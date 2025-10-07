extends Area2D

@export var controller = "player1" # also can be "player2", "pc"
var platform_speed
var ai_m
var max_y
var active
var ball_pos_y
var moving_dir = 0 # 0 - still, -1 - up, 1 - down

func _ready() -> void:
	platform_speed = GlobalInfo.platform_speed
	ai_m = GlobalInfo.ai_mult
	position.y = 100
	if controller == "player1":
		position.x = 5
		$ColorRect.color = Color(0.982, 0.565, 0.982, 1.0)
	else:
		position.x = get_viewport_rect().size.x - 9
		$ColorRect.color = Color(0.663, 1.0, 0.98, 1.0)
	max_y = get_viewport_rect().size.y - 85
	active = true
	ball_pos_y = get_viewport_rect().size.y / 2
	if controller == "player2":
		controller = GlobalInfo.player2
	if controller == "player1":
		controller = GlobalInfo.player1
	if controller.begins_with("pc"):
		platform_speed *= ai_m

func bot_process(delta: float) -> void:
	var mult = 1
	var c = ball_pos_y - (position.y + 40)
	if c < -15:
		mult = -1
	elif c > -15 and c < 15:
		mult = 0
	moving_dir = mult
	position.y += mult * platform_speed * delta
	position = position.clamp(Vector2(-1000,5), Vector2(1000, max_y))

func _process(delta: float) -> void:
	if not active:
		return
	if controller == "pc2" or controller == "pc1":
		bot_process(delta)
		return
	moving_dir = 0
	if (controller == "player1" and Input.is_action_pressed("up_1")) or (controller == "player2" and Input.is_action_pressed("up_2")):
		position.y -= platform_speed * delta
		position = position.clamp(Vector2(-1000,5), Vector2(1000, max_y))
		moving_dir = -1
	elif (controller == "player1" and Input.is_action_pressed("down_1")) or (controller == "player2" and Input.is_action_pressed("down_2")):
		position.y += platform_speed * delta
		position = position.clamp(Vector2(-1000,5), Vector2(1000, max_y))	
		moving_dir = 1
