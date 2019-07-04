extends CanvasLayer

export var prefix_text = 'Stars collected: '
# Called when the node enters the scene tree for the first time.
func _ready():
	set_process(true)
	get_parent().get_node('Player').connect('collected_star', self, '_on_Player_collected_star')

func _process(delta):
	pass

func _on_Player_collected_star():
	$RichTextLabel.text = prefix_text + str(get_parent().get_node('Player').num_stars_collected)