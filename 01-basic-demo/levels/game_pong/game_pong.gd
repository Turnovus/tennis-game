extends Node2D


var ball = preload("res://entities/ball/ball_pong.tscn")
var count = 4
var active_ball = null


func _process(delta):
	$PlayerScore.text = str(get_parent().points_player)
	$EnemyScore.text = str(get_parent().points_enemy)


func _on_start_timeout():
	count = count - 1
	if count > 0:
		$Audio/Count.play()
		$StartTimer.start()
	else:
		$Audio/Start.play()
		var new_ball = ball.instantiate()
		new_ball.rotation = PI * 0.7
		new_ball.position.y = get_viewport_rect().size.y * 0.5
		new_ball.position.x = get_viewport_rect().size.x * 0.5
		add_child(new_ball)
		active_ball = new_ball


func player_point():
	$Audio/Score.play()
	get_parent().points_player += 1


func enemy_point():
	$Audio/Score.play()
	get_parent().points_enemy += 1
