extends CharacterBody3D

@onready var camera : Camera3D = $Camera3D

var speed : float = 3
@export var canMove : bool = true
var gravity = ProjectSettings.get_setting("physics/3d/default_gravity")
@onready var walking : AudioStreamPlayer3D = $Walking


func _ready() -> void:
	Input.set_mouse_mode(Input.MOUSE_MODE_CAPTURED)

func _input(event: InputEvent) -> void:
	if event is InputEventMouseMotion and canMove:
		camera.rotation_degrees.x -= event.relative.y * Global.sensitivity
		camera.rotation_degrees.x = clamp(camera.rotation_degrees.x, -70, 90)
		rotation_degrees.y -= event.relative.x * Global.sensitivity

func _process(delta: float) -> void:
	if walking:
		if velocity and not walking.playing:
			walking.play()
		elif not velocity:
			walking.stop()
	
	if not (Dialogic.dialogActive or Global.menuActive) :
		Input.set_mouse_mode(Input.MOUSE_MODE_CAPTURED)
		canMove = true
	else:
		canMove = false
		Input.set_mouse_mode(Input.MOUSE_MODE_VISIBLE)
	

func _physics_process(delta: float) -> void:
	if not is_on_floor():
		velocity.y -= gravity * delta
	
	if canMove:
		move()
	else:
		velocity = Vector3.ZERO
	
	move_and_slide()

func move():
	var input_dir = Input.get_vector("A", "D", "W", "S")
	var direction = (transform.basis * Vector3(input_dir.x, 0, input_dir.y)).normalized()

	if direction:
		velocity.x = direction.x * speed
		velocity.z = direction.z * speed
	else:
		velocity.x = move_toward(velocity.x, 0, speed)
		velocity.z = move_toward(velocity.z, 0, speed)
