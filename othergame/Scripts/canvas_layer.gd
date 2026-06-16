extends CanvasLayer

@export var task: String = ""
@export var cursorOn : bool = true
@export var noFade : bool
func _ready() -> void:
	if cursorOn:
		$Cursor1.visible = true
	else:
		$Cursor1.visible = false
