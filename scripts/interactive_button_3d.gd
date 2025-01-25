# Button3D.gd
extends StaticBody3D

signal send_item(item: String)
signal send_button_state(id, state: bool)


@onready var control_btn = $MeshInstance3D/ObjBtn/SubViewportContainer/SubViewport/Button
@onready var viewport = $MeshInstance3D/ObjBtn/SubViewportContainer/SubViewport
@onready var obj_btn = $MeshInstance3D/ObjBtn
@onready var animPlayer = $AnimationPlayer
@export var is_item : bool = false
@export var item : String = ""
@export var toggle : bool = false
@export var id : int

var toggle_state : bool = false

# Src used : https://forum.godotengine.org/t/any-ideas-on-how-make-an-interactible-button-in-a-3d-space/4366/2
func _ready():
	connect("input_event", Callable(self, "_on_Button3D_input_event"), 0)
	control_btn.connect("pressed", Callable(self, "_on_Button_pressed"), 0)
	

func _on_Button3D_input_event(_camera, event, _position, _normal, _shape_idx):
	if event is InputEventMouseButton:
		if event.pressed:
			control_btn.emit_signal("pressed")
			control_btn.set_pressed(true)
		else:
			control_btn.set_pressed(false)

func _on_Button_pressed():
	if toggle:
		if toggle_state:
			animPlayer.play_backwards("toggle")
		else:
			animPlayer.play("toggle")
		toggle_state = !toggle_state
	else:
		animPlayer.play("press_down")

	if is_item:
		visible = false
		send_item.emit(item)
	else:
		send_button_state.emit(id, toggle_state)
