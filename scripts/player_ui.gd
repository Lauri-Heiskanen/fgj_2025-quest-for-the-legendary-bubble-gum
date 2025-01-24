extends Control

var health : int = 100

@onready var lbl_hp : Label = $MarginContainer/Health


# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	lbl_hp.text = "HP: " + str(health)


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass
