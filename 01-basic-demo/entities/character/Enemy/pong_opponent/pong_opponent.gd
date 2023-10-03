extends "res://entities/character/tennis_player/tennis_player.gd"


@export var move_speed: float
@export var rot_speed: float


func _ready():
	super._ready()
	rotation = PI * 0.5


func _process(delta):
	super._process(delta)
	
	var ball = get_parent().active_ball
	if (ball == null):
		return
	
	var ball_dist = abs(position.y - ball.position.y)
	
	if ball.position.y > position.y:
		position.y += min(ball_dist, move_speed * delta * 100)
	else:
		position.y -= min(ball_dist, move_speed * delta * 100)
	
	if cooldown_time <= 0 and $HitArea.has_overlapping_areas():
		rotation = PI * 0.5 + randf_range(PI * -0.3, PI * 0.3)
		swing()
		return
	
	if rotation != PI * 0.5:
		if rotation > PI * 0.5:
			rotation = max(PI * 0.5, rotation - rot_speed * delta * 100)
		else:
			rotation = min(PI * 0.5, rotation + rot_speed * delta * 100)
