extends Area3D
@export_file("res://Echoes-of-the-Unseen-Restart/scenes_asset/buildinginside.tscn") var target_scene: String

var is_player_in_door: bool = false

func _ready() -> void:
	body_entered.connect(on_body_entered)
	body_exited.connect(_on_body_exited)

func _unhandled_input(event: InputEvent) -> void:
	if is_player_in_door and event.is_action_pressed("interact"):
		if target_scene:
			get_tree().change_scene_to_file("res://Echoes-of-the-Unseen-Restart/asset_import/assets_tscn/buildinginside.tscn")
		else:
			print("Missing target scene file on this door!")

func _on_body_entered(body: Node3D) -> void:
	if body.is_in_group("player"):
		is_player_in_door = false

func _on_bosy_exited(body: Node3D) -> void:
	if body.is_in_group("player"):
		is_player_in_door = false
