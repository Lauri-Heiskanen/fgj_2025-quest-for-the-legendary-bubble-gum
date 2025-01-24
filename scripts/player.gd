extends CharacterBody3D


const STEP = 20.0
const JUMP_VELOCITY = 4.5

@onready var head : MeshInstance3D = $Head
@onready var cam_first : Camera3D = $Head/First

var is_moving: bool = false
var is_rotating: bool = false
var delta_sum: float = 0

var target_rot: Quaternion = Quaternion(transform.basis)
var target_pos: Transform3D

var motion : int = 0
var turn : int = 0

func _ready() -> void:
	# Player cam as main
	cam_first.make_current()


func _physics_process(delta: float) -> void:
	
	if Input.is_action_pressed("forward"):
		if !is_rotating && !is_moving:
			if Quaternion(transform.basis) == Quaternion(0, 0, 0, 1).normalized(): # facing front
				is_moving = true
				delta_sum = 0
				target_pos = transform
			elif Quaternion(transform.basis) == Quaternion(0, 1, 0, 0).normalized(): # faciong back
				is_moving = true
				delta_sum = 0
				target_pos = transform
				
			
			

	elif Input.is_action_pressed("backward"):
		if !is_rotating && !is_moving:
			# is_moving = true
			delta_sum = 0
			print("backward")
		
	elif Input.is_action_pressed("left"):
		if !is_rotating && !is_moving:
			is_rotating = true
			delta_sum = 0
			target_rot = (Quaternion(Vector3(0, 1, 0), deg_to_rad(90)).normalized() * Quaternion(transform.basis)).normalized()
			
	elif Input.is_action_pressed("right"):
		if !is_rotating && !is_moving:
			is_rotating = true
			delta_sum = 0
			target_rot = (Quaternion(Vector3(0, -1, 0), deg_to_rad(90)).normalized() * Quaternion(transform.basis)).normalized()
	
	if is_rotating:
		delta_sum += delta * 2 # rotation speed multiplier
		if delta_sum > 1:
			delta_sum = 1
	elif is_moving:
		delta_sum += delta  # movement speed multiplier
		if delta_sum > 1:
			delta_sum = 1
	
	if is_rotating:
		if delta_sum == 1:
			transform.basis = Basis(target_rot)
			is_rotating = false
		elif delta_sum < 1:
			transform.basis = Basis(Quaternion(transform.basis).slerp(target_rot, delta_sum))
			
	if is_moving:
		if delta_sum == 1:
			transform.basis = Basis(target_rot)
			is_rotating = false
		elif delta_sum < 1:
			transform.basis = Basis(Quaternion(transform.basis).slerp(target_rot, delta_sum))


	move_and_slide()

func _input(event):
	# Capture and free mouse
	if event is InputEventMouseButton:
		Input.mouse_mode = Input.MOUSE_MODE_CAPTURED
	if event.is_action_pressed("ui_cancel"):
		Input.mouse_mode = Input.MOUSE_MODE_VISIBLE
	
