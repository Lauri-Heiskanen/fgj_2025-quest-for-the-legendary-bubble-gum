extends Control

@onready var hotbar : HBoxContainer = $hotbar_container/hotbar
@onready var slots : Array = hotbar.get_children()
@onready var tl : ColorRect = $TransitionLayer

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	tl.color = Color(25,22,21,0)
	var i : int = 0
	while i < 4:
		var item = get_parent().player_items[i]
		if item != null:
			slots[i].get_children()[1].texture = load("res://uiTextures/" + item + ".png")
		i += 1


func _on_player_items_changed(index, new_item):
	if new_item != null:
		slots[index].get_children()[1].texture = load("res://uiTextures/" + new_item + ".png")
	else:
		slots[index].get_children()[1].texture = null
