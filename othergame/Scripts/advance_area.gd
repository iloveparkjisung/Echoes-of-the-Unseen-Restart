extends StaticBody3D

@export_file var nextScene : String
@export var displayName : String

func Advance():
	var anim : AnimationPlayer = get_tree().get_first_node_in_group("trAnim")
	anim.play("fadeIn")
	anim.nextScene = nextScene
	
	$Audio.play()

func GetDisplayName():
	return displayName
