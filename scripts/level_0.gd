extends Node3D

var levelUp = false
@onready var lvl_end = $Level_End

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(_delta: float) -> void:
	if(levelUp):
		if lvl_end.get_fin():
			get_tree().change_scene_to_file("res://level/level 1.tscn")

func levelUP():
	levelUp = true


func _on_area_3d_body_entered(body: Node3D) -> void:
	if body == $Player:
		lvl_end.play_audio()
		levelUP()


func _on_interactive_lever_3d_send_lever_state_change(id: int, state: bool) -> void:
	if (id == 0 and state):
		$Door.openDoor()
		$DoorWay/Door.openDoor()


func _on_interactive_button_3d_send_button_state(id: int, _toggle_state: bool) -> void:
	if (id == 1):
		$Door.closeDoor()
