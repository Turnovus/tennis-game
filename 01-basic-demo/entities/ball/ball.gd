@tool
extends "res://entities/bases/directional_character.gd"


@export var boundary_left: int = 0
@export var boundary_top: int = 0
@export var boundary_right: int = 10
@export var boundary_bottom: int = 10

@export var base_speed: float = 5
@export var collision_resolution: float = 0.1


var volley = 0


func _ready():
	super._ready()
	connect("area_entered", Callable(self, "_on_area_entered"))
	$CPUParticles2D.emission_sphere_radius = radius


func _draw():
	super._draw()
	if Engine.is_editor_hint():
		draw_rect(
			Rect2(
				boundary_left - position.x, 
				boundary_top - position.y, 
				boundary_right - boundary_left, 
				boundary_bottom - boundary_top
			)
			, color, false
		)


func _process(delta):
	super._process(delta)
	
	if Engine.is_editor_hint():
		return
	
	var speed = base_speed
	
	if not get_parent().get_parent().do_grabbing() or not has_overlapping_areas():
		speed += volley * 50
	
	var movement = speed * delta
	
	while movement > 0:
		var i = min(movement, collision_resolution)
		move(i)
		movement -= i


func _on_area_entered(area: Area2D):
	if not area.has_method("on_ball_hit"):
		return
	
	if get_parent().get_parent().do_collide():
		rotation = area.position.angle_to_point(position)
	area.on_ball_hit()
	$BounceSound.play()


func move(amount):
	var bounce = false
	
	position = position + Vector2(0, amount).rotated(rotation)
	
	if position.x > boundary_right:
		rotation = 0.5 * PI - rotation + 1.5 * PI
		position.x = clampf(position.x, boundary_left, boundary_right)
		bounce = true
		on_bounce_right()
	if position.x < boundary_left:
		rotation = 0.5 * PI - rotation + 1.5 * PI
		position.x = clampf(position.x, boundary_left, boundary_right)
		bounce = true
		on_bounce_left()
	if position.y > boundary_bottom or position.y < boundary_top:
		rotation = 0.5 * PI - rotation + 0.5 * PI
		position.y = clampf(position.y, boundary_top, boundary_bottom)
		bounce = true
	
	if bounce:
		if get_parent().get_parent().all_or_nothing():
			volley = 0
		else:
			volley = max(0, volley - 1)
		rotation = fmod(rotation, 2 * PI)
		$BounceSound.play()


func hit_ball(hit_by: Node2D):
	rotation = hit_by.hit_rotation()
	
	if get_parent().get_parent().do_volley():
		volley += 1


func update_label():
	super.update_label()
	$Label.text += "\nV "
	$Label.text += str(volley)


func on_bounce_left():
	pass


func on_bounce_right():
	pass
