extends "res://entities/bases/directional_character.gd"


@export var cooldown: int = 100


var cooldown_time: float = 0


func _ready():
	super._ready()
	$HitArea/CollisionShape2D.position.y = radius


func _process(delta):
	super._process(delta)
	
	cooldown_time = max(0, cooldown_time - delta * 100)


func _draw():
	var hit_ratio = (cooldown - cooldown_time) / cooldown
	var hit_color = Color(1, hit_ratio, hit_ratio)
	draw_circle($HitArea/CollisionShape2D.position, $HitArea/CollisionShape2D.shape.radius, hit_color)
	super._draw()


func on_ball_hit():
	pass


func swing():
	if cooldown_time > 0:
		return false
	
	var any_hit = false
	for area in $HitArea.get_overlapping_areas():
		if area.has_method("hit_ball"):
			any_hit = true
			area.hit_ball(self)
	
	if any_hit:
		$Audio/SwingHit.play()
	else:
		$Audio/SwingMiss.play()
	
	cooldown_time = cooldown
	
	return any_hit


func hit_rotation() -> float:
	return rotation + 2 * PI
