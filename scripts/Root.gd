extends Node2D

func _ready():
	set_process(true)
	
	get_node('Player').connect('is_dead', self, '_on_player_is_dead')

func _process(delta):
	pass
	
func _on_player_is_dead():
	get_tree().quit()
