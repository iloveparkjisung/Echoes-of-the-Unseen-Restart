extends Node
class_name ActivateDialogAfterTime
@export var time : float
@export var dialogicTimeline : String
enum activateIf {READY, X, NULL}
@export var reqX : int = 0
@export var reqNull : Node
@export var state : activateIf = activateIf.READY

func _ready() -> void:
	if state == activateIf.READY:
		await get_tree().create_timer(time).timeout
		Activate()

func _process(delta: float) -> void:
	if state == activateIf.X and Global.x == reqX:
		Activate()
	elif state == activateIf.NULL and reqNull == null:
		Activate()

func Activate():
	Dialogic.start(dialogicTimeline)
	
	var p := get_tree().get_first_node_in_group("player")
	if p:
		Global.delay = true
		p.canMove = false
	queue_free()
