extends MarginContainer

export var next_scene = ''

# Called when the node enters the scene tree for the first time.
func _ready():
	set_process_input(true)

# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta):
#	pass

func _input(event):
	if event.is_action_pressed('next_scene'):
		get_tree().change_scene(next_scene)
