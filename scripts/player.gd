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
@onready var ray2 : RayCast3D = $Head/First/RayCast3D2

@onready var hotbar : HBoxContainer = $PlayerUI/hotbar_container/hotbar
var player_items : Array = [null, null, null, null] # create array to store item information
var player_active_slot : int = 0

var is_moving: bool = false
var is_rotating: bool = false
var delta_sum: float = 0

var target_rot: Quaternion = Quaternion(transform.basis)
var target_pos: Transform3D = transform

var deathReason: String = ""
# src: https://www.reddit.com/r/godot/comments/8ft84k/deleted_by_user/
func get_obj():
	var mouse = get_viewport().get_mouse_position()
	var from_vec3 = cam_first.project_ray_origin(mouse)
	var to_vec3 = from_vec3 + cam_first.project_ray_normal(mouse) * 6
	var sp = get_world_3d().direct_space_state
	var sel = sp.intersect_ray(PhysicsRayQueryParameters3D.create(from_vec3, to_vec3))
	return sel


func _ready() -> void:
	# Player cam as main
	cam_first.make_current()
	death_timer.wait_time = time_until_demise
	airsupply.value = time_until_demise
	death_timer.start()

func _process(_delta: float) -> void:
	airsupply.value = death_timer.time_left


func _physics_process(delta: float) -> void:
	if Input.is_action_pressed("forward"):
		if !is_rotating && !is_moving && !ray.is_colliding():
			is_moving = true
			delta_sum = 0
			var player_quat = Quaternion(transform.basis)
			target_pos = transform.translated(ray.target_position.rotated(player_quat.get_axis().normalized(), player_quat.get_angle()))
	
	elif Input.is_action_pressed("backward"):
		if !is_rotating && !is_moving && !ray2.is_colliding():
			is_moving = true
			delta_sum = 0
			var player_quat = Quaternion(transform.basis)
			target_pos = transform.translated(ray2.target_position.rotated(player_quat.get_axis().normalized(), player_quat.get_angle()))
	
		
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

func _input(event: InputEvent) -> void:
	if event.is_action_pressed("LMB"):
		var sel = get_obj()
		print(sel)
		if !sel.has("collider"):
			return
		print("Coll: ", sel["collider"])
		var body = sel["collider"]
		if body.has_method("set_condition"):
			print("req: ", body.get_itemname())
			print("items: ", player_items)
			if player_items.has(body.get_itemname()):
				body.set_condition(true)
				print("Item found from inv")
			

func add_item(item: String):
	var i : int = 0
	while i < 4:
		if player_items[i] == null:
			player_items[i] = item
			items_changed.emit(i, item)
			break
		i += 1
	print(player_items)
	
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
	die()

func die() -> void:
	get_tree().change_scene_to_file("res://scenet/MainMenu.tscn")
