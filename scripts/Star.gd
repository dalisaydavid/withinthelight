extends Node2D

signal on_shine
signal on_remove_shine
var shining = false

func _ready():
	pass
	
func _on_Area2D_body_entered(body):
	if body.get_name() == 'Player':
		emit_signal('on_shine')
		shining = true

func _on_Area2D_body_exited(body):
	if body.get_name() == 'Player':
		emit_signal('on_remove_shine')
		shining = false
