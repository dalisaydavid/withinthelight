extends Node2D

signal can_exit

func _ready():
	pass

func _on_Area2D_body_entered(body):
	if body.get_name() == 'Player':
		emit_signal('can_exit')
