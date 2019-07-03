extends KinematicBody2D

signal is_dead
export var jumps = 2
export var max_jumps = 2
export var walk_speed = 5
export var jump_force = 25000
export var gravity = 500
export var shrink_rate = Vector2(.004, .004)
export var grow_rate = Vector2(.0025, .0025)
export var width_scale_constraints = Vector2(.025, 1)
export var height_scale_constraints = Vector2(.025, 1)
var velocity = Vector2()
var speed_y = 0.0
var motion_x = 0.0
var last_direction = 'right'
var moon_shine = false
var star_shine = false
var can_exit = false

func _ready():
	set_physics_process(true)
	set_process_input(true)
	
	# @TODO: This sucks.
	get_parent().get_node('Moon').connect('on_shine', self, '_on_Moon_on_shine')
	get_parent().get_node('Moon').connect('on_remove_shine', self, '_on_Moon_on_remove_shine')
	
	var stars = get_tree().get_nodes_in_group("Star")
	for star in stars:
		print(star.get_name())
		get_parent().get_node(star.get_name()).connect('on_shine', self, '_on_Star_on_shine')
		get_parent().get_node(star.get_name()).connect('on_remove_shine', self, '_on_Star_on_remove_shine')

	get_parent().get_node('Exit').connect('can_exit', self, '_on_Exit_on_can_exit')
func do_nothing():
	pass

func _physics_process(delta):
	velocity.x = 0
	
	# Slowly reduces in size when out of the light.
	if moon_shine:
		grow(grow_rate)
	elif star_shine:
		do_nothing()
	else:
		shrink(shrink_rate)
		
	handle_movement()
	handle_animation()
	velocity.y += gravity
	move_and_slide(velocity * delta)

func handle_animation():
	$AnimatedSprite.animation = last_direction

# Check if on ground
func on_ground():
	return $VerticalRay.is_colliding() and 'Floor' in $VerticalRay.get_collider().get_name()

func jump():
	if on_ground():
		jumps = max_jumps
		
	if jumps <= 0:
		return
		
	velocity.y = -jump_force*scale.y
	jumps -= 1

func _input(event):
	if event.is_action_pressed('jump'):
		jump()
	if event.is_action_pressed('exit'):
		if can_exit:
			get_tree().quit()
			can_exit = false

func handle_movement():
	if Input.is_key_pressed(KEY_A):
		velocity.x = -walk_speed
		last_direction = 'left'
	elif Input.is_key_pressed(KEY_D):
		velocity.x =  walk_speed
		last_direction = 'right'

func shrink(shrink_rate):
	scale = Vector2(
		clamp(
			scale.x-shrink_rate.x, 
			width_scale_constraints.x,
			width_scale_constraints.y
		), 
		clamp(
			scale.y-shrink_rate.y, 
			height_scale_constraints.x, 
			height_scale_constraints.y
		)
	)
	
	if scale.x == width_scale_constraints.x and scale.y == height_scale_constraints.x:
		emit_signal('is_dead')

func grow(grow_rate):
	scale = Vector2(
		clamp(
			scale.x+grow_rate.x, 
			width_scale_constraints.x, 
			width_scale_constraints.y
		), 
		clamp(
			scale.y+grow_rate.y, 
			height_scale_constraints.x, 
			height_scale_constraints.y
		)
	)
	
func _on_Moon_on_shine():
	moon_shine = true
	
func _on_Moon_on_remove_shine():
	moon_shine = false

func _on_Star_on_shine():
	star_shine = true
	
func _on_Star_on_remove_shine():
	star_shine = false
	
func _on_Exit_on_can_exit():
	can_exit = true