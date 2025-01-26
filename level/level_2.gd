extends Node3D



var levelUp = false

func _ready():
	$Door2.openDoor()
	#$DoorWay.openDoor()

func _process(delta: float) -> void:
	if(levelUp):
		get_tree().change_scene_to_file("res://level/level 3.tscn")

func levelUP():
	levelUp = true

func _on_area_3d_body_entered(body: Node3D) -> void:
	if body == $Player:
		levelUP()

func _on_interactive_lever_3d_send_button_state(id, toggle_state):
	if (id == 0 and toggle_state):
		$Door2.closeDoor()
		$Door.openDoor()
	elif (id == 0 and !toggle_state):
		$Door.closeDoor()
		$Door2.openDoor()


func _on_conditional_action_send_state(id: int, state: bool) -> void:
	$DoorWay.openDoor()
