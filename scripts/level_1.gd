extends Node3D

var condition_list : Array = [false, false] 
@onready var wall = $Wall
@onready var hatch = $hatch
@onready var lvl_end = $Level_End

var hatch_state : bool = false
var wall_state : bool = false

var levelUp : bool = false

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(_delta: float) -> void:
	if(levelUp):
		if lvl_end.get_fin():
			get_tree().change_scene_to_file("res://level/level 2.tscn")


func _on_btn_door_send_button_state(id: int, toggle_state: bool) -> void:
	hatch.play_anim(hatch_state)
	hatch_state = !hatch_state


func _on_level_end_body_entered(body: Node3D) -> void:
	if body == $Player:
		lvl_end.play_audio()
		levelUp = true


func _on_conditional_action_send_state(id: int, state: bool) -> void:
	#print("Condition met")
	wall.play_anim(wall_state)
	wall_state = !wall_state
	
