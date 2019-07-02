extends KinematicBody2D

export var walk_speed = 500000
export var jump_force = 500000
export var gravity = 850000
export var shrink_rate = Vector2(.005, .005)
export var grow_rate = Vector2(.0025, .0025)
export var width_scale_constraints = Vector2(.25, 1)
export var height_scale_constraints = Vector2(.25, 1)
var velocity = Vector2()
var speed_y = 0.0
var motion_x = 0.0
var last_direction = ''
var grow_on = false

func _ready():
	set_physics_process(true)
	set_process_input(true)
	
	# @TODO: This sucks.
	get_parent().get_node('Moon').connect('on_shine', self, '_on_Moon_on_shine')
	get_parent().get_node('Moon').connect('on_remove_shine', self, '_on_Moon_on_remove_shine')
func _physics_process(delta):
	velocity.x = 0
	
	# Slowly reduces in size when out of the light.
	if grow_on:
		grow(grow_rate)
	else:
		shrink(shrink_rate)
		
	handle_movement()

	speed_y += gravity * delta
	velocity.y = speed_y * delta
	move_and_slide(velocity * delta)

func _input(event):
	if event.is_action_pressed('up'):
		speed_y = -jump_force

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
	grow_on = true
	
func _on_Moon_on_remove_shine():
	grow_on = false