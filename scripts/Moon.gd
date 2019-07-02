extends Node2D

signal on_shine
signal on_remove_shine

func _ready():
	set_process(true)
#	set_process_input(true)

func _process(delta):
	position = get_viewport().get_mouse_position()
	
func _on_Area2D_body_entered(body):
	if body.get_name() == 'Player':
		emit_signal('on_shine')

func _on_Area2D_body_exited(body):
	if body.get_name() == 'Player':
		emit_signal('on_remove_shine')

