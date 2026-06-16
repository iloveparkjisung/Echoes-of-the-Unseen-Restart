extends StaticBody3D

@export var targetPos : Node3D
@export var displayName : String = "Door"

func Teleport():
	var anim : AnimationPlayer = get_tree().get_first_node_in_group("trAnim")
	anim.play("fadeIn")
	anim.teleport = true
	anim.nextPos = targetPos
	
	if displayName == "Door":
		$TeleportAudio.play()

func GetDisplayName() -> String:
	return displayName
