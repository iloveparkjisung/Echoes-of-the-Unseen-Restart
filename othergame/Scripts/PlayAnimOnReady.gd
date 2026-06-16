extends AnimationPlayer

@export var animName: String

func _ready() -> void:
	play(animName)
