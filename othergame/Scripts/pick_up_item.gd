extends StaticBody3D

@export var dName : String

func GetDisplayName():
	return dName

func Destroy():
	Global.delay = false
	queue_free()
