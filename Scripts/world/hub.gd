extends Sprite2D

@onready var game: Node2D = $".."
@onready var label: Label = $Label

@export var hub_individual_limit := 10
@export var health := 100
@export var is_enemy := false

const individual_scene: PackedScene = preload("res://Scenes/individual.tscn")
var individuals: Array[Node2D]= []
var spawn_points: Array[Marker2D] = []

func _process(_delta: float) -> void:
	label.text = str(health)
	

func _ready() -> void:
	for i in get_children():
		if i is Marker2D:
			spawn_points.append(i)


func _on_timer_timeout() -> void:
	if individuals.size() < hub_individual_limit:
		var spawn_point := spawn_points[randi_range(0, spawn_points.size() - 1)]
		var individual := individual_scene.instantiate()
		individuals.append(individual)
		
		#Find the position of the spawn_point relative to the game center
		individual.global_position = game.to_local(spawn_point.global_position)
		game.add_child(individual)
	
