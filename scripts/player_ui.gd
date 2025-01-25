extends Control

@onready var lbl_player_is_rotating : Label = $MarginContainer2/VBoxContainer/is_rotating
@onready var lbl_player_is_moving : Label = $MarginContainer2/VBoxContainer/is_moving

@onready var hotbar : HBoxContainer = $hotbar_container/hotbar

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	lbl_player_is_rotating.text = "is_rotating: " + str(get_parent().is_rotating)
	lbl_player_is_moving.text = "is_moving: " + str(get_parent().is_moving)

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	lbl_player_is_rotating.text = "is_rotating: " + str(get_parent().is_rotating)
	lbl_player_is_moving.text = "is_moving: " + str(get_parent().is_moving)
	
