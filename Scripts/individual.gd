extends CharacterBody2D

@onready var navigation_agent_2d: NavigationAgent2D = $NavigationAgent2D

@export var speed := 150

var target := position
static var last_click_position = Vector2(0, 0)

func _ready() -> void:
	pass

func _input(event):
	# Use is_action_pressed to only accept single taps as input instead of mouse drags.
	if event.is_action_pressed(&"click"):
		last_click_position = get_global_mouse_position()

func _physics_process(delta):
	move_to_click()

#Moves the individual towards the location of the mouse click
func move_to_click():
	navigation_agent_2d.target_position = last_click_position
	var current_individual_position := global_position
	var next_path_position := navigation_agent_2d.get_next_path_position()
	var new_velocity := current_individual_position.direction_to(next_path_position) * speed
	
	navigation_agent_2d.set_velocity(new_velocity)

	move_and_slide()

func _on_navigation_agent_2d_velocity_computed(safe_velocity: Vector2) -> void:
	velocity = safe_velocity
