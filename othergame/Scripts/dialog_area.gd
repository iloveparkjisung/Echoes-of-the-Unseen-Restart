extends Area3D

@export var timeline : String
func _on_body_entered(body: Node3D) -> void:
	if body.is_in_group("player"):
		Dialogic.start(timeline)
		body.canMove = false
		queue_free()
