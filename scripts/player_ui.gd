extends Control

@onready var lbl_player_is_rotating : Label = $MarginContainer2/VBoxContainer/is_rotating
@onready var lbl_player_is_moving : Label = $MarginContainer2/VBoxContainer/is_moving

@onready var hotbar : HBoxContainer = $hotbar_container/hotbar
@onready var slots : Array = hotbar.get_children()

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	lbl_player_is_rotating.text = "is_rotating: " + str(get_parent().is_rotating)
	lbl_player_is_moving.text = "is_moving: " + str(get_parent().is_moving)
	
	var i : int = 0
	while i < 4:
		var item = get_parent().player_items[i]
		if item != null:
			slots[i].get_children()[1].texture = load("res://uiTextures/" + item + ".png")
		i += 1

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	lbl_player_is_rotating.text = "is_rotating: " + str(get_parent().is_rotating)
	lbl_player_is_moving.text = "is_moving: " + str(get_parent().is_moving)

func _on_player_items_changed(index, new_item):
	if new_item != null:
		slots[index].get_children()[1].texture = load("res://uiTextures/" + new_item + ".png")
	else:
		slots[index].get_children()[1].texture = null
		
