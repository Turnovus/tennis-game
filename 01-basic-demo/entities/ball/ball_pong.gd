extends "res://entities/ball/ball.gd"


func on_bounce_left():
	get_parent().enemy_point()
	position.x += 75
	#position.y = get_viewport_rect().size.y * 0.5
	#position.x = get_viewport_rect().size.x * 0.5


func on_bounce_right():
	get_parent().player_point()
	position.x -= 75
	#position.y = get_viewport_rect().size.y * 0.5
	#position.x = get_viewport_rect().size.x * 0.5
