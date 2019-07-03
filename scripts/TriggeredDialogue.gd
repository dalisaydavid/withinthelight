extends Node2D

func _ready():
	pass # Replace with function body.

func _on_Area2D_body_entered(body):
	if body.get_name() == 'Player':
		set_visible(true)

func _on_Area2D_body_exited(body):
	if body.get_name() == 'Player':
		set_visible(false)

