extends Node3D

@onready var audioStreamPlayer : AudioStreamPlayer3D = $AudioStreamPlayer3D

var isDoorOpen = false
# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(_delta: float) -> void:
	pass


func openDoor() -> void:
	if(!isDoorOpen):
		isDoorOpen = true
		$AnimationPlayer.play("openDoor")
		audioStreamPlayer.play()

func closeDoor() -> void:
	if(isDoorOpen):
		isDoorOpen = false
		$AnimationPlayer.play_backwards("openDoor")
		audioStreamPlayer.play()
