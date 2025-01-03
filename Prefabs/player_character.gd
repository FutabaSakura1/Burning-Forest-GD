extends CharacterBody3D
@export_category("PLAYER MOVEMENT")
@export var TURN_SPEED = 50.0
@export var SPEED = 1.5
@export var BACK_SPEED = 0.75
@export var JUMP_VELOCITY = 65.0
var aiming = false
@export var rotating = false
@export var MOVESPEED := 1.5
var twist_input := 0.0
var pitch_input := 0.0
@export var mouse_sens := 0.001 

@export_category("USER OPTIONS")
@export var lockCamera : bool = false
func _ready() -> void:
	Input.set_mouse_mode(Input.MOUSE_MODE_CAPTURED)

func _unhandled_input(event: InputEvent) -> void:
	if event is InputEventMouseMotion:
		if Input.get_mouse_mode() == Input.MOUSE_MODE_CAPTURED:
			twist_input = - event.relative.x * mouse_sens
			pitch_input = - event.relative.y * mouse_sens
func _physics_process(delta: float) -> void:
	# Add the gravity.
	var move_dir = 0
	var turn_dir = 0
	if !aiming:
		if Input.is_action_pressed("forward"):
			move_dir += 1
		if Input.is_action_pressed("back"):
			move_dir -= 1
		if Input.is_action_pressed("right"):
			turn_dir -= 1
		if Input.is_action_pressed("left"):
			turn_dir += 1
		rotating = turn_dir != 0
		rotation_degrees.y += (turn_dir * TURN_SPEED * delta)
		if lockCamera != false:
			$TwistPivot.rotation_degrees.y -= (turn_dir * TURN_SPEED * delta)
		if move_dir == -1:
			MOVESPEED = BACK_SPEED
		elif move_dir == 1:
			MOVESPEED = SPEED
		velocity = -(global_transform.basis.z * MOVESPEED * move_dir)
		if !is_on_floor():
			velocity += get_gravity() * 24 * delta
		# Handle jump.
		#if Input.is_action_just_pressed("ui_accept") and is_on_floor():
			#velocity.y = JUMP_VELOCITY
	$TwistPivot.rotate_y(twist_input)
	$TwistPivot/PitchPivot.rotate_x(pitch_input)
	$TwistPivot/PitchPivot.rotation.x = clamp ($TwistPivot/PitchPivot.rotation.x, -0.5, 0.5)
	twist_input = 0.0
	pitch_input = 0.0
	
	move_and_slide()
