extends CharacterBody3D


const STEP = 20.0
const JUMP_VELOCITY = 4.5

@onready var head : MeshInstance3D = $Head
@onready var cam_first : Camera3D = $Head/First
@onready var ray : RayCast3D = $Head/First/RayCast3D

var is_moving: bool = false
var is_rotating: bool = false
var delta_sum: float = 0

var target_rot: Quaternion = Quaternion(transform.basis)
var target_pos: Transform3D = transform

var motion : int = 0
var turn : int = 0

var _mouse_motion : Vector2

func _ready() -> void:
	# Player cam as main
	cam_first.make_current()


func _physics_process(delta: float) -> void:
	
	_mouse_motion.y = clamp(_mouse_motion.y, -1550, 1550)
	ray.transform.basis = Basis(Vector3(0, _mouse_motion.x * -0.001, 0), Vector3.UP, Vector3.FORWARD)
	ray.transform.basis = Basis(Vector3(_mouse_motion.y * -0.001, 0, 0), Vector3.UP, Vector3.FORWARD)
	
	if Input.is_action_pressed("forward"):
		if !is_rotating && !is_moving:
			# check if facing front
			if Quaternion(transform.basis) == Quaternion(0, 0, 0, 1).normalized():
				is_moving = true
				delta_sum = 0
				target_pos = transform.translated(Vector3(0, 0, -4))
			# check if facing back
			elif Quaternion(transform.basis) == Quaternion(0, 1, 0, 0).normalized():
				is_moving = true
				delta_sum = 0
				target_pos = transform.translated(Vector3(0, 0, 4))
	
	elif Input.is_action_pressed("backward"):
		if !is_rotating && !is_moving:
			# check if facing front
			if Quaternion(transform.basis) == Quaternion(0, 0, 0, 1).normalized():
				is_moving = true
				delta_sum = 0
				target_pos = transform.translated(Vector3(0, 0, 4))
			# check if facing back
			elif Quaternion(transform.basis) == Quaternion(0, 1, 0, 0).normalized():
				is_moving = true
				delta_sum = 0
				target_pos = transform.translated(Vector3(0, 0, -4))
		
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
		delta_sum += delta * 2 # movement speed multiplier
		if delta_sum > 1:
			delta_sum = 1
	
	if is_rotating:
		if delta_sum == 1:
			transform.basis = Basis(target_rot)
			is_rotating = false
		elif delta_sum < 1:
			transform.basis = Basis(Quaternion(transform.basis).slerp(target_rot, delta_sum))
			
	if is_moving:
		print(delta_sum)
		if delta_sum == 1:
			transform = target_pos
			is_moving = false
		elif delta_sum < 1:
			transform = transform.interpolate_with(target_pos, delta_sum)


	move_and_slide()
	
#
func _input(event):
	# Capture and free mouse
	if event is InputEventMouseMotion:
		_mouse_motion += event.relative
		#
	#if event is InputEventMouseButton:
		#Input.mouse_mode = Input.MOUSE_MODE_CAPTURED
	#if event.is_action_pressed("ui_cancel"):
		#Input.mouse_mode = Input.MOUSE_MODE_VISIBLE
	#
