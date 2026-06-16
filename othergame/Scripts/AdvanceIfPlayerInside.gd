extends Area3D

@export_file var nextScene : String

func _on_body_entered(body: Node3D) -> void:
	if body.is_in_group("player"):
		var anim : AnimationPlayer = get_tree().get_first_node_in_group("trAnim")
		anim.play("fadeIn")
		anim.nextScene = nextScene
		queue_free()
