extends Area2D

var speed
var screen_size
var center
var direction = Vector2(1, -1)   # start direction
var start_speed                  # start speed
var max_speed                    # max speed
var speed_inc                    # speed increase per hit
var anim_time = 0.25             # hit animation time (from play_animation)
var disabled

signal hit(wall) # emits when touches wall, wall = 0 - left, 1 - right
signal platform_touch(platform) # emits when touches platform, 0 - left, 1 - right

func disable() -> void:
	hide()
	speed = 0
	disabled = true

func enable() -> void:
	play_animation("spawn")
	show()
	speed = start_speed
	disabled = false
	
func _ready() -> void:
	start_speed = GlobalInfo.start_speed
	max_speed = GlobalInfo.max_speed
	speed_inc = GlobalInfo.speed_increase
	screen_size = get_viewport_rect().size
	center = get_viewport_rect().size / 2
	screen_size.x -= 7
	screen_size.y -= 7
	disable()

func _physics_process(delta: float) -> void:
	direction = direction.normalized()
	var velocity = direction * speed
	position += velocity * delta
	position = position.clamp(Vector2(7, 7), screen_size)
	if position.x == 7 and direction.x < 0 and not disabled:
		disable()
		$MissPlayer.play()
		await get_tree().create_timer(0.5).timeout
		hit.emit(0)
	if position.x == screen_size.x and direction.x > 0 and not disabled:
		disable()
		$MissPlayer.play()
		await get_tree().create_timer(0.5).timeout
		hit.emit(1)
	if position.y == 7 or position.y == screen_size.y:
		direction.y = -direction.y

# This func is called externally when ball is touching the block
func play_animation(n: String) -> void:
	$BallSprite.play(n)
	await get_tree().create_timer(anim_time).timeout
	$BallSprite.play("default")

# This func is called externally to place ball and start game
func start():
	var first = randi_range(0, 1)
	if first == 0: 
		first = -1
	position = center
	direction = Vector2(first, randf_range(-0.7, 0.7))
	enable()

func _on_area_shape_entered(area_rid: RID, area: Area2D, area_shape_index: int, local_shape_index: int) -> void:
	direction.x = -direction.x
	if position.x < center.x:
		play_animation("hit0")
		platform_touch.emit(0)
	else:
		play_animation("hit1")
		platform_touch.emit(1)
	speed += speed_inc
	if speed > max_speed:
		speed = max_speed
	$PongPlayer.play()
