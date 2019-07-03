extends Node2D

export var text = 'Test'
export var collision_dimensions = Vector2(1,1)

func _ready():
	$RichTextLabel.text = text

func _on_Area2D_body_entered(body):
	if body.get_name() == 'Player':
		set_visible(true)

func _on_Area2D_body_exited(body):
	if body.get_name() == 'Player':
		set_visible(false)

