extends Node3D

var isDoorOpen = false
# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass


func openDoor() -> void:
	if(!isDoorOpen):
		isDoorOpen = true
		$AnimationPlayer.play("openDoor")

func _on_animation_player_animation_finished(anim_name: StringName) -> void:
	pass # Replace with function body.
