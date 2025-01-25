extends Node3D

@onready var player = $Player

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass

func _receive_item(item) -> void:
	print("Received item:", item)


func _receive_state(id: int, state: bool) -> void:
	print("State from: ", id, " : ", state)
