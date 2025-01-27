extends StaticBody3D

signal send_lever_stateChange(id: int, state: bool)

@onready var control_btn = $MeshInstance3D/Pivot/Lever/SubViewportContainer/SubViewport/Button
@onready var viewport = $MeshInstance3D/Pivot/Lever/SubViewportContainer/SubViewport
@onready var pivot = $MeshInstance3D/Pivot
@onready var animPlayer = $AnimationPlayer
@export var button_action : String = ""
@export var toggle : bool = false
@export var id : int = 0

var toggle_state : bool = false
var cnt = 0

func _ready():
	connect("input_event", Callable(self, "_on_Button3D_input_event"), 0)
	control_btn.connect("pressed", Callable(self, "_on_Button_pressed"), 0)
	
func _on_Button3D_input_event(_camera, event, _position, _normal, _shape_idx):
	if event is InputEventMouseButton:
		
		if event.pressed:
			control_btn.toggle_mode = !control_btn.toggle_mode
			control_btn.set_pressed(control_btn.toggle_mode)
			control_btn.emit_signal("pressed")
			send_lever_stateChange.emit(id, control_btn.toggle_mode)

func _on_Button_pressed():
	if toggle_state:
		animPlayer.play_backwards("lever_action")
		toggle_state = !toggle_state
	else:
		animPlayer.play("lever_action")
		toggle_state = !toggle_state
