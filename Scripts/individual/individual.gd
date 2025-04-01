extends CharacterBody2D

@onready var navigation_agent_2d: NavigationAgent2D = $navigation
@onready var visual: Node2D = $visual

@export var speed := 150

var target := position
static var last_click_position = Vector2(0, 0)

var passed_velocity: Vector2

func _ready() -> void:
	pass

func _input(event):
	# Use is_action_pressed to only accept single taps as input instead of mouse drags.
	if event.is_action_pressed(&"click"):
		last_click_position = get_global_mouse_position()

func _physics_process(_delta):
	move_to_target()
	passed_velocity = navigation_agent_2d.velocity
	visual.tick(passed_velocity)

#Moves the individual towards the location of the mouse click
func move_to_target():
	navigation_agent_2d.target_position = last_click_position
	var current_individual_position := global_position
	var next_path_position := navigation_agent_2d.get_next_path_position()
	var new_velocity := current_individual_position.direction_to(next_path_position) * speed
	
	navigation_agent_2d.set_velocity(new_velocity)

	move_and_slide()

func _on_navigation_agent_2d_velocity_computed(safe_velocity: Vector2) -> void:
	velocity = safe_velocity
