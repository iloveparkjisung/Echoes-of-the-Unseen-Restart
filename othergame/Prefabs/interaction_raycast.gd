extends RayCast3D

@onready var trAnim = get_tree().get_first_node_in_group("transitionAnim")

func _process(delta):
	if is_colliding():
		Global.canInteract() = true
		if Input.is_action_just_released("Interact"):
			if get_collider().is_in_group("dialog") and not Global.dialogActive and get_collider().db != null:
				get_collider().db.active()
			if get_collider().is_in_group("SceneChanger"):
				Global.nextScene = get_collider().nextScene
				if get_collider().mode == get_collider().a.CHANGE_ROOM:
					trAnim.play("end")
				elif get_collider().mode == get_collider().a.CHANGE_SCENE:
					trAnim.play("endNS")
		else:
			Global.canInteract = false
