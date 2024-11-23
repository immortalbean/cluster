extends CharacterBody2D

@export var speed = 150

var target := position

func _ready() -> void:
	pass

func _input(event):
	# Use is_action_pressed to only accept single taps as input instead of mouse drags.
	if event.is_action_pressed(&"click"):
		target = get_global_mouse_position()

func _physics_process(delta):
	move_to_click()

#Moves the individual towards the location of the mouse click
func move_to_click():
	#Rotating smoothly
	var movement_vector := target - global_position
	var angle := movement_vector.angle() 
	var current_rotation := global_rotation 
	global_rotation = lerp_angle(current_rotation, angle, 0.04)
	
	#Gas!
	velocity = transform.x * speed
	
	if position.distance_to(target) > 50:
		move_and_slide()
