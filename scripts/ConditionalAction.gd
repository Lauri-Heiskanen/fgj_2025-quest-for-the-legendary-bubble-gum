extends Node

signal send_state(id: int, state: bool)

@export var id : int = 0
@export var required_item : String = ""
var condition_met : bool = false


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	if condition_met:
		send_state.emit(id, condition_met)
		condition_met = false
		
func get_itemname() -> String:
	return required_item
	

func set_condition(val):
	condition_met = val
	
func get_condition():
	return condition_met
	
