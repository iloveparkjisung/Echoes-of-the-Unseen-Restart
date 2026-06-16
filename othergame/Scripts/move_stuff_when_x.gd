extends Node
class_name MoveStuffWhenX
@export var stuff: Node3D

@export var requiredX : int = 0
enum states {MOVE_WHEN_X, MOVE_WHEN_NULL}
@export var currentState : states = states.MOVE_WHEN_X
@export var reqiredNull : Node
func _ready() -> void:
	stuff.position.x -= 99999
	Global.x = 0

func _process(delta: float) -> void:
	if currentState == states.MOVE_WHEN_X and Global.x == requiredX:
		stuff.position.x += 99999
		Global.x = 0
		queue_free()
	elif currentState == states.MOVE_WHEN_NULL and reqiredNull == null:
		stuff.position.x += 99999
		queue_free()
