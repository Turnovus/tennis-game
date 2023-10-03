@tool
extends Area2D


@export var radius: float = 1
@export var color: Color


# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	queue_redraw()


func _draw():
	draw_circle(Vector2.ZERO, radius, color)
