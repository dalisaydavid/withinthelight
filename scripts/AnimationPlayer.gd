extends AnimationPlayer

# Declare member variables here. Examples:
# var a = 2
# var b = "text"

# Called when the node enters the scene tree for the first time.
func _ready():
	var anim = get_animation("Blink")
	anim.set_loop(true)
	play("Blink")

# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta):
#	pass
