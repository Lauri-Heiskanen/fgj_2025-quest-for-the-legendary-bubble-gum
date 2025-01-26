extends Node3D

var condition_list : Array = [false, false] 
@onready var wall = $Wall
@onready var hatch = $hatch
var hatch_state : bool = false
var wall_state : bool = false

var levelUp : bool = false

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(_delta: float) -> void:
	if(levelUp):
		get_tree().change_scene_to_file("res://level/level 2.tscn")


func _on_btn_door_send_button_state(id: int, toggle_state: bool) -> void:
	hatch.play_anim(hatch_state)
	hatch_state = !hatch_state


func _on_level_end_body_entered(body: Node3D) -> void:
	print("ready to move to next place")
	if body == $Player:
		levelUp = true


func _on_conditional_action_send_state(id: int, state: bool) -> void:
	#print("Condition met")
	wall.play_anim(wall_state)
	wall_state = !wall_state
	
