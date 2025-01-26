extends StaticBody3D

@onready var animPlayer : AnimationPlayer = $AnimationPlayer

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass

func play_anim(reverse: bool = false):
	if reverse:
		animPlayer.play_backwards("open")
	else:
		animPlayer.play("open")
	
