extends Node2D


var elimination = preload("res://levels/game_field/game_field.tscn")
var pong = preload("res://levels/game_pong/game_pong.tscn")
var mode = 0
var points_player = 0
var points_enemy = 0


func _input(event):
	if event.is_action_pressed("ui_cancel"):
		end_mode()


func start_elimination():
	mode = 1
	$Control.hide()
	add_child(elimination.instantiate())


func start_pong():
	mode = 2
	points_player = 0
	points_enemy = 0
	$Control.hide()
	add_child(pong.instantiate())


func end_mode():
	mode = 0
	for i in get_children():
		if i != $Control:
			i.queue_free()
	$Control.show()


func do_volley() -> bool:
	return $Control/settings_menu/HBoxContainer/PlaySettings/Volley.button_pressed


func do_debug() -> bool:
	return $Control/settings_menu/HBoxContainer/PlaySettings/Debug.button_pressed


func do_grabbing() -> bool:
	return $Control/settings_menu/HBoxContainer/PlaySettings/Grabbing.button_pressed

func do_momentum() -> bool:
	return $Control/settings_menu/HBoxContainer/PlaySettings/Momentum.button_pressed


func do_collide() -> bool:
	return $Control/settings_menu/HBoxContainer/PlaySettings/Collide.button_pressed


func all_or_nothing() ->bool:
	return $Control/settings_menu/HBoxContainer/PlaySettings/VolleyAllOrNone.button_pressed


func get_tweak_accel() -> float:
	return $Control/settings_menu/HBoxContainer/Tweaks/PlayerAccel.value


func get_tweak_decel() -> float:
	return $Control/settings_menu/HBoxContainer/Tweaks/PlayerDecel.value
