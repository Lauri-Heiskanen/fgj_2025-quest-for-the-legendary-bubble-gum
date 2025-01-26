extends Control

func _on_video_stream_player_finished():
	get_tree().change_scene_to_packed(load("res://level/level 0.tscn"))
