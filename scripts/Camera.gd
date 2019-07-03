extends Camera2D

func _ready():
	set_process(true)
	
#	limit_bottom = get_parent().get_node('Floor').global_position.x

func _process(delta):
	position = get_parent().get_node('Player').global_position
