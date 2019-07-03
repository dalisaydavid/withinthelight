extends StaticBody2D

export var use_random_sprite = false

# Called when the node enters the scene tree for the first time.
func _ready():
	if use_random_sprite:
		get_node('Sprite' + str(randi()%3+1)).set_visible(true)

# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta):
#	pass
