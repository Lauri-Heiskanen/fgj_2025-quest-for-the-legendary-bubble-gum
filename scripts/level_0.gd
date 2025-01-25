extends Node3D

var levelUp = false
# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	if(levelUp):
		get_tree().change_scene_to_file("res://level/level 1.tscn")

func levelUP():
	levelUp = true


func _on_area_3d_body_entered(body: Node3D) -> void:

	if body == $Player:
		levelUP()