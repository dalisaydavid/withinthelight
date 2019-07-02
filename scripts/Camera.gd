extends Camera2D

func _ready():
	set_process(true)

func _process(delta):
	position = get_parent().get_node('Player').global_position
