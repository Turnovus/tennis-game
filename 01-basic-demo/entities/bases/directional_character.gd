@tool
extends "res://entities/bases/circle.gd"


func _ready():
	update_radius()
	
	if (Engine.is_editor_hint()):
		return
	
	if get_parent().get_parent().do_debug():
		$Label.show()
	else:
		$Label.hide()


func _process(delta):
	update_label()
	super._process(delta)
	if Engine.is_editor_hint():
		update_radius()
		return


func update_radius():
	$CollisionShape2D.shape.radius = radius
	$Line2D.points[1].y = radius * 1.4


func update_label():
	$Label.rotation = -rotation
	$Label.text = "X: %d Y: %d R: %f" % [position.x, position.y, rotation]
