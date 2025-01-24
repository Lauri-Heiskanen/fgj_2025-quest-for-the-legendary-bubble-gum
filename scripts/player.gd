extends CharacterBody3D


const STEP = 20.0
const JUMP_VELOCITY = 4.5

@onready var head : MeshInstance3D = $Head
@onready var cam_first : Camera3D = $Head/First


var motion : int = 0
var turn : int = 0

func _ready() -> void:
	# Player cam as main
	cam_first.make_current()


func _physics_process(delta: float) -> void:
	# Add the gravity.
	if not is_on_floor():
		velocity += get_gravity() * delta

	if Input.is_action_pressed("forward"):
		print("forward")

	elif Input.is_action_pressed("backward"):
		print("backward")

	move_and_slide()

func _input(event):
	# Capture and free mouse
	if event is InputEventMouseButton:
		Input.mouse_mode = Input.MOUSE_MODE_CAPTURED
	if event.is_action_pressed("ui_cancel"):
		Input.mouse_mode = Input.MOUSE_MODE_VISIBLE
	
	if event.is_action_pressed("left"):
		rotate_y(deg_to_rad(90))
		print("Left: ", rotation)

	if event.is_action_pressed("right"):
		rotate_y(deg_to_rad(-90))
		
		print("Right: ", rotation)
