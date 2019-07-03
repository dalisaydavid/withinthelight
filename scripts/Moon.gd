extends Node2D

signal on_shine
signal on_remove_shine

func _ready():
	set_process(true)
#	Input.set_mouse_mode(Input.MOUSE_MODE_HIDDEN)

func _process(delta):
	global_position = get_global_mouse_position()
	
func _on_Area2D_body_entered(body):
	if body.get_name() == 'Player':
		emit_signal('on_shine')

func _on_Area2D_body_exited(body):
	if body.get_name() == 'Player':
		emit_signal('on_remove_shine')

