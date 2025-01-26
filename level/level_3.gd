extends Node3D

var levelUp = false

func _ready():
	$Door.openDoor()
	$Door7.openDoor()

func _process(delta: float) -> void:
	if(levelUp):
		get_tree().change_scene_to_file("res://level/level 4.tscn")

func levelUP():
	levelUp = true

func _on_area_3d_body_entered(body: Node3D) -> void:
	if body == $Player:
		levelUP()

func _on_interactive_button_3d_send_button_state(id, toggle_state):
	if id == 1:
		$Door5.openDoor()
	elif id == 2:
		$Door4.openDoor()


func _on_lever_send_button_state(id, toggle_state):
	if id == 0:
		$Door6.openDoor()
		if toggle_state:
			$Door.closeDoor()
			$Door2.openDoor()
		else:
			$Door2.closeDoor()
			$Door.openDoor()
	elif id == 1:
		$Door6.openDoor()
		if toggle_state:
			$Door7.closeDoor()
			$Door5.openDoor()
		else:
			$Door5.closeDoor()
			$Door7.openDoor()


func _on_wrench_send_item(item):
	$Player.add_item(item)
