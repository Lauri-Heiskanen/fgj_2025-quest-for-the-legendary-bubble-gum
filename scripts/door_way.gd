extends Node3D

var doorOpen = false

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(_delta: float) -> void:
	pass

func openDoor() -> void:
	if(!doorOpen):
		doorOpen = true
		$Door/AnimationPlayer.play("openDoor")

func closeDoor() -> void:
	if(doorOpen):
		doorOpen = false
		$Door/AnimationPlayer.play_backwards("openDoor")
