extends Label

var currentTask : String:
	get():
		return currentTask
	set(value):
		currentTask = value
		text = currentTask
@onready var cl : CanvasLayer = $".."
func _ready() -> void:
	currentTask = cl.task
	text = currentTask
