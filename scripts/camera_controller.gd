class_name CamerController extends Node3D
@export var debug : bool = false
@export_category("References")
@export var player_controller : PlayerController
@export var component_mouse_capture : MouseCaptureComponent
@export_category("Camera Settings")
@export_group("Camera Tilt")
@export_range(-90, -60) var tilt_lower_limit : int = -90
@export_range(60, 90) var tilt_upper_limit : int = 90

var _rotation : Vector3

func _process(delta: float) -> void:
	update_camera_rotation(component_mouse_capture._mouse_input)


func update_camera_rotation(input: Vector2) -> void:
	# 1. Accumulate input (Mouse Y is vertical/pitch, Mouse X is horizontal/yaw)
	# Note: Usually we subtract input.y so moving mouse UP looks UP
	_rotation.x -= input.y 
	_rotation.y -= input.x
	
	# 2. Clamp the vertical look (convert limits to radians)
	_rotation.x = clamp(_rotation.x, deg_to_rad(tilt_lower_limit), deg_to_rad(tilt_upper_limit))
	
	# 3. Apply horizontal rotation to the PLAYER body
	if player_controller:
		player_controller.rotation.y = _rotation.y
		
	# 4. Apply vertical rotation to THIS camera node locally
	rotation.x = _rotation.x
	
	# 5. Clear the Z axis just in case to prevent camera tilt/roll
	rotation.z = 0.0
