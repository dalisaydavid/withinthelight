extends Node2D

func _ready():
	set_process(true)
	
	get_node('Player').connect('is_dead', self, '_on_player_is_dead')
	get_node('Player').connect('exited', self, '_on_player_exited')
	
func _process(delta):
	pass
	
func _on_player_is_dead():
	get_tree().reload_current_scene()
	
func _on_player_exited():
	print('exited...')
	get_tree().change_scene("res://scenes/Scene2.tscn")

