extends "res://entities/character/tennis_player/tennis_player.gd"


var dying = false
var player


func _ready():
	super._ready()
	$DieTimer.connect("timeout", Callable(self, "_on_death_timeout"))


func _process(delta):
	super._process(delta)
	
	if dying:
		rotation += delta * 65
		return;
	
	if player == null:
		for i in get_parent().get_children():
			if i.name == "player":
				player = i
	
	if player != null:
		rotation = position.angle_to_point(player.position) - PI * 0.5
	
	if $HitArea.has_overlapping_areas():
		swing()


func on_ball_hit():
	if dying:
		return
	
	$Audio/Hurt.play()
	$DieTimer.start()
	dying = true


func _on_death_timeout():
	queue_free()


func update_label():
	super.update_label()
	if not dying:
		return
	$Label.text += "\nI'm dead!"
