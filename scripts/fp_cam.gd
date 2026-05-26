extends Node3D

var sensiivity = 0.2

func _input(event: InputEvent) -> void:
	if event is InputEventMouseMotion:
		get_parent().rotate_y(deg_to_rad(-event.relative.x * sensiivity))
		rotate_x(deg_to_rad(-event.relative.y * sensiivity))
		rotation.x = clamp(rotation.x, deg_to_rad(-90), deg_to_rad(90))
