# Button3D.gd
extends StaticBody3D

class_name ItemScript

signal send_item(item: String)


@onready var control_btn = $SubViewportContainer/SubViewport/Button
@onready var viewport = $SubViewportContainer/SubViewport
@onready var animPlayer = $AnimationPlayer
@export var item : String = ""

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
	print("An item")
	visible = false
	send_item.emit(item)
