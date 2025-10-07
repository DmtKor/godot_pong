extends Node2D

var pause
var score

func _process(delta: float) -> void:
	$Platform2.ball_pos_y = $Ball.position.y
	$Platform1.ball_pos_y = $Ball.position.y

func _ready() -> void:
	pause = false
	$Ball.start()
	$Platform1.active = true
	$Platform2.active = true
	score = Vector2i(0, 0)

func _on_hud_play() -> void:
	pause = false
	$Ball.start()
	$Platform1.active = true
	$Platform2.active = true

func _on_hud_stop() -> void:
	pause = true
	$Ball.disable()
	$Platform1.active = false
	$Platform2.active = false

func _on_ball_hit(wall) -> void:
	if not pause:
		$Ball.start()
	if wall == 0:
		score.x += 1
	else: 
		score.y += 1
	$HUD.update_score(score)

func _on_ball_platform_touch(platform: Variant) -> void:
	var dir = 0
	if platform == 0:
		dir = $Platform1.moving_dir 
	else: 
		dir = $Platform2.moving_dir 
	$Ball.direction.y += dir * 0.5
