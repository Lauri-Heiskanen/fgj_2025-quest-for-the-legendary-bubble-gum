extends StaticBody3D

class_name ButtonScript

signal send_button_state(id : int, toggle_state: bool)

@onready var control_btn = $SubViewportContainer/SubViewport/Button
@onready var viewport = $SubViewportContainer/SubViewport
@onready var animPlayer = $AnimationPlayer

@export var button_action : String = ""
@export var id : int = 0
@export var toggle : bool

var toggle_state : bool = false

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
	if toggle_state:
		animPlayer.play_backwards("action")
	else:
		animPlayer.play("action")

	toggle_state = !toggle_state
	send_button_state.emit(id, toggle_state)
