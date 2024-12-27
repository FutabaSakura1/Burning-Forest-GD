extends CharacterBody3D
@export_category("PLAYER MOVEMENT")
@export var TURN_SPEED = 50.0
@export var SPEED = 1.5
@export var BACK_SPEED = 0.75
@export var JUMP_VELOCITY = 65.0
var aiming = false
@export var rotating = false
@export var MOVESPEED = 1.5

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
	move_and_slide()
