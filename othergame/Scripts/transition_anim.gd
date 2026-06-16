extends AnimationPlayer

@export_file var nextScene : String
@export var teleport : bool
@export var nextPos : Node3D
@onready var noFade : bool = $"../..".noFade

func _ready() -> void:
	if not noFade:
		play("fadeOut")
	else:
		$"..".visible = false

func Advance(scene : String) -> void:
	play("fadeIn")
	$"..".visible = true
	nextScene = scene

func changeScenes():
	if not teleport:
		get_tree().change_scene_to_file(nextScene)
	else:
		get_tree().get_first_node_in_group("player").global_position = nextPos.global_position
		_ready()
