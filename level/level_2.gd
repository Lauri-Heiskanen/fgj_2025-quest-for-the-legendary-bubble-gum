extends Node3D



var levelUp = false

func _process(delta: float) -> void:
	if(levelUp):
		get_tree().change_scene_to_file("res://level/level 3.tscn")

func levelUP():
	levelUp = true

func _on_area_3d_body_entered(body: Node3D) -> void:
	if body == $Player:
		levelUP()

func _on_interactive_lever_3d_send_lever_state_change(id: int, state: bool) -> void:
	print(id)
	print(state)
	if (id == 0 and state):
		$hatchW/AnimationPlayer.play("open")
		$hatchP/AnimationPlayer.play_backwards("open")
	elif (id == 0 and !state):
		$hatchW/AnimationPlayer.play_backwards("open")
		$hatchP/AnimationPlayer.play("open")
