extends Sprite2D

@onready var game: Node2D = $".."

@export var hub_limit := 10

const individual_scene: PackedScene = preload("res://Scenes/individual.tscn")
var individuals: Array[Node2D]= []
var spawn_points: Array[Marker2D] = []

func _ready() -> void:
	for i in get_children():
		if i is Marker2D:
			spawn_points.append(i)

func _on_timer_timeout() -> void:
	if individuals.size() < hub_limit:
		var spawn_point := spawn_points[randi_range(0, spawn_points.size() - 1)]
		var individual := individual_scene.instantiate()
		individuals.append(individual)
		individual.position = spawn_point.global_position
		game.add_child(individual)
