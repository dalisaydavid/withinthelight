extends CanvasLayer

export var prefix_text = 'Stars collected: '

# Called when the node enters the scene tree for the first time.
func _ready():
	set_process(true)
	
	get_parent().get_node('Player').connect('on_collect', self, '_on_Player_on_collect_star')

func _process(delta):
	pass

func _on_Player_on_collect_star():
	pass