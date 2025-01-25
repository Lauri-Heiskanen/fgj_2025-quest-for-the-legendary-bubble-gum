extends CharacterBody3D

signal items_changed(index: int, new_item)

const STEP = 20.0
const JUMP_VELOCITY = 4.5

@export var time_until_demise : int = 100
@onready var airsupply : TextureProgressBar = $PlayerUI/AirSupplyBar
@onready var death_timer : Timer = $Time_Until_Demise
@onready var head : MeshInstance3D = $Head
@onready var cam_first : Camera3D = $Head/First
@onready var ray : RayCast3D = $Head/First/RayCast3D

@onready var hotbar : HBoxContainer = $PlayerUI/hotbar_container/hotbar
var player_items : Array = [null, null, null, null] # create array to store item information
var player_active_slot : int = 0

var is_moving: bool = false
var is_rotating: bool = false
var delta_sum: float = 0

var target_rot: Quaternion = Quaternion(transform.basis)
var target_pos: Transform3D = transform

var step 

func _ready() -> void:
	# Player cam as main
	cam_first.make_current()
	death_timer.wait_time = time_until_demise
	airsupply.value = time_until_demise
	death_timer.start()

func _process(delta: float) -> void:
	airsupply.value = death_timer.time_left

func _physics_process(delta: float) -> void:
	if Input.is_action_pressed("forward"):
		if !is_rotating && !is_moving:
			# check if facing front
			if Quaternion(transform.basis) == Quaternion(0, 0, 0, 1).normalized():
				var space_state : PhysicsDirectSpaceState3D = get_world_3d().direct_space_state
				var ray_cast_res = space_state.intersect_ray(PhysicsRayQueryParameters3D.create(transform.origin, transform.translated(Vector3(0, 0, -4)).origin))
				print(ray_cast_res)
				if !ray_cast_res.has("position"):
					is_moving = true
					delta_sum = 0
					target_pos = transform.translated(Vector3(0, 0, -4))
			# check if facing back
			elif Quaternion(transform.basis) == Quaternion(0, 1, 0, 0).normalized():
				var space_state : PhysicsDirectSpaceState3D = get_world_3d().direct_space_state
				var ray_cast_res = space_state.intersect_ray(PhysicsRayQueryParameters3D.create(transform.origin, transform.translated(Vector3(0, 0, 4)).origin))
				print(ray_cast_res)
				if !ray_cast_res.has("position"):
					is_moving = true
					delta_sum = 0
					target_pos = transform.translated(Vector3(0, 0, 4))
	
	elif Input.is_action_pressed("backward"):
		if !is_rotating && !is_moving:
			# check if facing front
			if Quaternion(transform.basis) == Quaternion(0, 0, 0, 1).normalized():
				var space_state : PhysicsDirectSpaceState3D = get_world_3d().direct_space_state
				var ray_cast_res = space_state.intersect_ray(PhysicsRayQueryParameters3D.create(transform.origin, transform.translated(Vector3(0, 0, 4)).origin))
				if !ray_cast_res.has("position"):
					is_moving = true
					delta_sum = 0
					target_pos = transform.translated(Vector3(0, 0, 4))
			# check if facing back
			elif Quaternion(transform.basis) == Quaternion(0, 1, 0, 0).normalized():
				var space_state : PhysicsDirectSpaceState3D = get_world_3d().direct_space_state
				var ray_cast_res = space_state.intersect_ray(PhysicsRayQueryParameters3D.create(transform.origin, transform.translated(Vector3(0, 0, -4)).origin))
				if !ray_cast_res.has("position"):
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
	
	if Input.is_action_just_pressed("hotbar1"):
		player_active_slot = 0
	elif Input.is_action_just_pressed("hotbar2"):
		player_active_slot = 1
	elif Input.is_action_just_pressed("hotbar3"):
		player_active_slot = 2
	elif Input.is_action_just_pressed("hotbar4"):
		player_active_slot = 3
	
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
		if delta_sum == 1:
			transform = target_pos
			is_moving = false
		elif delta_sum < 1:
			transform = transform.interpolate_with(target_pos, delta_sum)

	move_and_slide()

func add_item(item: String):
	var i : int = 0
	while i < 4:
		if player_items[i] == null:
			player_items[i] = item
			items_changed.emit(i, item)
			break
		i += 1

func remove_item(item: String):
	var i : int = 0
	while i < 4:
		if player_items[i] == item:
			player_items[i] = null
			items_changed.emit(i, null)
			break
		i += 1

func has_item(item: String):
	for n in player_items:
		if n == item:
			return true
	return false


func _on_time_until_demise_timeout() -> void:
	
	#queue_free()
	pass # Replace with function body.
