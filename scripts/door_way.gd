extends Node3D

var doorOpen = false
var animation = false
# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	if(animation):
		pass

func openDoor() -> void:
	if(!doorOpen):
		doorOpen = true
		animation = true
