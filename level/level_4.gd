extends Node3D

var levelUp = false
var trap_enabled = true

@onready var lvl_end = $Level_End

func _ready():
	$Door2.openDoor()
	$Door3.openDoor()
	$Door4.openDoor()
	$Door5.openDoor()
	$DoorWay2.openDoor()

func _process(delta: float) -> void:
	if(levelUp):
		if lvl_end.get_fin():
			get_tree().change_scene_to_file("res://level/level 5.tscn")

func levelUP():
	levelUp = true

func _on_area_3d_body_entered(body: Node3D) -> void:
	if body == $Player:
		lvl_end.play_audio()
		levelUP()

func _on_interactive_button_3d_send_button_state(id, toggle_state):
	if id == 0:
		$Door6.openDoor()


func _on_lever_send_button_state(id, toggle_state):
	if id == 1:
		if toggle_state:
			$Door2.closeDoor()
			$Door5.openDoor()
			$DoorWay2.openDoor()
		else:
			$Door5.closeDoor()
			$Door2.openDoor()
			$DoorWay2.closeDoor()
	elif id == 2:
		if toggle_state:
			$Door3.closeDoor()
			$Door4.openDoor()
			$DoorWay.openDoor()
		else:
			$Door4.closeDoor()
			$Door3.openDoor()
			$DoorWay.closeDoor()

func _on_area_3d_2_body_entered(body):
	if trap_enabled:
		print("asdasda")
		trap_enabled = false
		$DoorWay2.closeDoor()
		$Door.openDoor()
		$Door7.openDoor()
		$Door4.closeDoor()
		$Door5.closeDoor()
