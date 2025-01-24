extends Control

var health : int = 100

@onready var lbl_hp : Label = $MarginContainer/Health
@onready var lbl_player_is_rotating : Label = $MarginContainer2/VBoxContainer/is_rotating
@onready var lbl_player_is_moving : Label = $MarginContainer2/VBoxContainer/is_moving


# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	lbl_hp.text = "HP: " + str(health)
	lbl_player_is_rotating = $MarginContainer2/VBoxContainer/is_rotating
	lbl_player_is_rotating.text = "is_rotating: " + str(get_parent().is_rotating)
	lbl_player_is_moving = $MarginContainer2/VBoxContainer/is_moving
	lbl_player_is_moving.text = "is_moving: " + str(get_parent().is_moving)

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	lbl_player_is_rotating.text = "is_rotating: " + str(get_parent().is_rotating)
	lbl_player_is_moving.text = "is_moving: " + str(get_parent().is_moving)
	
