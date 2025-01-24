extends CharacterBody3D


const STEP = 20.0
const JUMP_VELOCITY = 4.5

@onready var head : MeshInstance3D = $Head
@onready var cam_first : Camera3D = $Head/First

var is_stationary = true
var delta_sum: float = 0
var target_rot = Quaternion(transform.basis)

var motion : int = 0
var turn : int = 0

func _ready() -> void:
	# Player cam as main
	cam_first.make_current()


func _physics_process(delta: float) -> void:
	
	if !is_stationary:
		delta_sum += delta
		if delta_sum > 1:
			delta_sum = 1
	
	if Input.is_action_pressed("forward"):
		print("forward")

	elif Input.is_action_pressed("backward"):
		print("backward")
		
	elif Input.is_action_pressed("left"):
		if is_stationary:
			is_stationary = false
			delta_sum = 0
			target_rot = (Quaternion(transform.basis) * Quaternion(0, 1, 0, 1)).normalized()
			print("Left")
			
	elif Input.is_action_pressed("right"):
		if is_stationary:
			is_stationary = false
			delta_sum = 0
			target_rot = (Quaternion(transform.basis) * Quaternion(0, -1, 0, 1)).normalized()
			print("Right")
	
	transform.basis = Basis(Quaternion(transform.basis).slerp(target_rot, delta_sum))
	
	if !is_stationary:
		if target_rot == Quaternion(transform.basis):
			is_stationary = true
			
		else:
			print(target_rot)
			print(Quaternion(transform.basis))
			print()


	move_and_slide()

func _input(event):
	# Capture and free mouse
	if event is InputEventMouseButton:
		Input.mouse_mode = Input.MOUSE_MODE_CAPTURED
	if event.is_action_pressed("ui_cancel"):
		Input.mouse_mode = Input.MOUSE_MODE_VISIBLE
	
