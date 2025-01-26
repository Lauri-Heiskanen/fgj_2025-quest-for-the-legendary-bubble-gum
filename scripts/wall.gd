extends Node3D

@onready var animPlayer = $AnimationPlayer


func play_anim(reverse : bool = false):
	if reverse:
		animPlayer.play_backwards("action")
	else:
		animPlayer.play("action")
		
