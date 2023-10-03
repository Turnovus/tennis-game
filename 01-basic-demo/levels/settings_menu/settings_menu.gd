extends Control


func elimination():
	get_parent().get_parent().start_elimination()


func pong():
	get_parent().get_parent().start_pong()


func _on_momentum_toggled():
	var momentum = $HBoxContainer/PlaySettings/Momentum.button_pressed
	$HBoxContainer/Tweaks/PlayerAccel.editable = momentum
	$HBoxContainer/Tweaks/PlayerDecel.editable = momentum
