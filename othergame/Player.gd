class_name PlayerController extends CharacterBody3D

@export var MOVE_SPEED: float = 50.0
@export var JUMP_SPEED: float = 2.0
@export var first_person: bool = false : 
	set(p_value):
		first_person = p_value
		if first_person:
			var tween: Tween = create_tween()
			tween.tween_property($CameraManager/Arm, "spring_length", 0.0, .33)
			tween.tween_callback($Body.set_visible.bind(false))
		else:
			$Body.visible = true
			create_tween().tween_property($CameraManager/Arm, "spring_length", 6.0, .33)

@export var gravity_enabled: bool = true :
	set(p_value):
		gravity_enabled = p_value
		if not gravity_enabled:
			velocity.y = 0
			
@export var collision_enabled: bool = true :
	set(p_value):
		collision_enabled = p_value
		$CollisionShapeBody.disabled = ! collision_enabled
		$CollisionShapeRay.disabled = ! collision_enabled

func _physics_process(delta: float) -> void:
	if not is_on_floor():
		velocity += get_gravity() * delta
	
	_input_dir = Input.get_vector("left", "right", "forward", "backward")
	var current_velocity = Vector2(_movement_velocity.x, _movement_velocity.z)
	var direction = (transform.basis * Vector3(_input_dir.x, 0, _input_dir.y).normalized())
	
	if direction:
		current_velocity = lerp(current_velocity, Vector2(direction.x, direction.z) * speed, acceleration)
	else:
		current_velocity = current_velocity.move_toward(Vector2.ZERO, deceleration)
	
	_movement_velocity = Vector3(current_velocity.x, velocity.y, current_velocity.y)
	velocity = _movement_velocity	
	
	move_and_slide()


var _input_dir : Vector2 = Vector2.ZERO
var _movement_velocity : Vector3 = Vector3.ZERO
var speed : float = 3.5
@export var acceleration : float = 0.1
@export var deceleration : float = 0.2

# Returns the input vector relative to the camera. Forward is always the direction the camera is facing
func get_camera_relative_input() -> Vector3:
	var input_dir: Vector3 = Vector3.ZERO
	if Input.is_key_pressed(KEY_A): # Left
		input_dir -= %Camera3D.global_transform.basis.x
	if Input.is_key_pressed(KEY_D): # Right
		input_dir += %Camera3D.global_transform.basis.x
	if Input.is_key_pressed(KEY_W): # Forward
		input_dir -= %Camera3D.global_transform.basis.z
	if Input.is_key_pressed(KEY_S): # Backward
		input_dir += %Camera3D.global_transform.basis.z
	if Input.is_key_pressed(KEY_E) or Input.is_key_pressed(KEY_SPACE): # Up
		velocity.y += JUMP_SPEED + MOVE_SPEED*.016
	if Input.is_key_pressed(KEY_Q): # Down
		velocity.y -= JUMP_SPEED + MOVE_SPEED*.016
	if Input.is_key_pressed(KEY_KP_ADD) or Input.is_key_pressed(KEY_EQUAL):
		MOVE_SPEED = clamp(MOVE_SPEED + .5, 5, 9999)
	if Input.is_key_pressed(KEY_KP_SUBTRACT) or Input.is_key_pressed(KEY_MINUS):
		MOVE_SPEED = clamp(MOVE_SPEED - .5, 5, 9999)
	return input_dir		


func _input(p_event: InputEvent) -> void:
	if p_event is InputEventMouseButton and p_event.pressed:
		if p_event.button_index == MOUSE_BUTTON_WHEEL_UP:
			MOVE_SPEED = clamp(MOVE_SPEED + 5, 5, 9999)
		elif p_event.button_index == MOUSE_BUTTON_WHEEL_DOWN:
			MOVE_SPEED = clamp(MOVE_SPEED - 5, 5, 9999)
	
	elif p_event is InputEventKey:
		if p_event.pressed:
			if p_event.keycode == KEY_V:
				first_person = ! first_person
			elif p_event.keycode == KEY_G:
				gravity_enabled = ! gravity_enabled
			elif p_event.keycode == KEY_C:
				collision_enabled = ! collision_enabled

		# Else if up/down released
		elif p_event.keycode in [ KEY_Q, KEY_E, KEY_SPACE ]:
			velocity.y = 0
