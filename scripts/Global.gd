extends Node

var dialogActive : bool
var canInteract : bool
var inventoryActive : bool
var nextScene : String

func _process(delta):
	if Input.is_action_just_pressed("Esc"):
		get_tree().quit()
