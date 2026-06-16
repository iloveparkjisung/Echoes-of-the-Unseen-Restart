extends Node

var sensitivity : float = 0.5

var x : int
var menuActive : bool
var shaderOn : bool = true :
	get():
		return shaderOn
	set(value):
		get_tree().get_first_node_in_group("shader").visible = value
		shaderOn = value


var overlayOn : bool = true :
	get():
		return overlayOn
	set(value):
		get_tree().get_first_node_in_group("overlay").visible = value
		overlayOn = value

var delay : bool = false
var canInteract : bool:
	set(newValue):
		canInteract = newValue
		if newValue == true:
			get_tree().get_first_node_in_group("cursor1").visible = false
			get_tree().get_first_node_in_group("cursor2").visible = true
		else:
			get_tree().get_first_node_in_group("cursor1").visible = true
			get_tree().get_first_node_in_group("cursor2").visible = false

func _ready() -> void:
	add_to_group("Global")

func _process(delta: float) -> void:
	if Dialogic.dialogActive:
		Input.set_mouse_mode(Input.MOUSE_MODE_VISIBLE)


func SetDelay(x : bool):
	delay = x
	get_tree().get_first_node_in_group("player").canMove = false


func Delay():
	var player : CharacterBody3D = get_tree().get_first_node_in_group("player")
	if player:
		player.canMove = true
	Input.set_mouse_mode(Input.MOUSE_MODE_HIDDEN)
	Input.set_mouse_mode(Input.MOUSE_MODE_CAPTURED)
	
	Dialogic.dialogActive = false
	await get_tree().create_timer(0.2).timeout
	delay = false

func _notification(what):
	if what == NOTIFICATION_APPLICATION_FOCUS_IN:
		fix_mouse_input()

func fix_mouse_input():
	if Input.mouse_mode == Input.MOUSE_MODE_CAPTURED:
		Input.mouse_mode = Input.MOUSE_MODE_HIDDEN
		await get_tree().process_frame
		await get_tree().process_frame
		Input.mouse_mode = Input.MOUSE_MODE_CAPTURED

func SetX(newX : int):
	x = newX

func SetNewTask(task : String):
	get_tree().get_first_node_in_group("task").currentTask = task
