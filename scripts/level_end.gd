extends Area3D

@onready var audio = $AudioStreamPlayer3D

var fin = false

func play_audio():
	audio.play()

func get_fin() -> bool:
	return fin

func _on_audio_stream_player_3d_finished() -> void:
	fin = true
