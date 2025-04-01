extends Node2D


func tick(velocity: Vector2) -> void:
	rotation = lerp_angle(rotation, velocity.angle(), 0.2)
