extends "res://entities/character/tennis_player/tennis_player.gd"


@export var movement_speed: int = 10


var acceleration: float = 1
var deceleration: float = 1
var use_momentum: bool = false
var pong: bool = false
var momentum : Vector2 = Vector2()


func _ready():
	super._ready()
	print(get_parent().get_parent().mode)
	acceleration = get_parent().get_parent().get_tweak_accel()
	deceleration = get_parent().get_parent().get_tweak_decel()
	use_momentum = get_parent().get_parent().do_momentum()
	pong = get_parent().get_parent().mode == 2


func _process(delta):
	super._process(delta)
	
	rotation = position.angle_to_point(get_viewport().get_mouse_position()) - PI * 0.5
	
	var max_x = get_viewport_rect().size.x
	if pong:
		max_x /= 2
	
	if not use_momentum:
		if Input.is_action_pressed("ui_up"):
			if position.y > 0:
				position.y -= movement_speed
		if Input.is_action_pressed("ui_down"):
			if position.y < get_viewport_rect().size.y:
				position.y += movement_speed
		if Input.is_action_pressed("ui_left"):
			if position.x > 0:
				position.x -= movement_speed
		if Input.is_action_pressed("ui_right"):
			if(position.x < max_x):
				position.x += movement_speed
		return
	
	var movement = Vector2()
	if Input.is_action_pressed("ui_up"):
		movement.y -= 1
	if Input.is_action_pressed("ui_down"):
		movement.y += 1
	if Input.is_action_pressed("ui_left"):
		movement.x -= 1
	if Input.is_action_pressed("ui_right"):
		movement.x += 1
	
	if movement == Vector2.ZERO:
		momentum.x = sign(momentum.x) * max(abs(momentum.x) - deceleration, 0)
		momentum.y = sign(momentum.y) * max(abs(momentum.y) - deceleration, 0)
	
	momentum += movement.normalized() * acceleration
	
	var magnitude = abs(momentum.length())
	momentum = momentum.normalized()
	momentum *= min(magnitude, movement_speed)
	
	position += momentum
	position.x = clamp(position.x, 0, max_x)
	position.y = clamp(position.y, 0, get_viewport_rect().size.y)


func _input(event):
	if event.is_action_pressed("player_action"):
		swing()


func update_label():
	super.update_label()
	$Label.text += " " + str((cooldown - cooldown_time) / cooldown)
	if pong:
		$Label.text += "\nI'm playing pong!"
	if use_momentum:
		$Label.text += "\n%f %f" % [momentum.x, momentum.y]


func on_ball_hit():
	super.on_ball_hit()
	cooldown_time = cooldown
	$Audio/Hurt.play()
