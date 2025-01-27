extends Control


signal btn_start()
signal btn_settings()
signal btn_credits()
signal btn_exit()

@onready var level = preload("res://scenet/intro_video.tscn")

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass


func _on_start_pressed() -> void:
	get_tree().change_scene_to_packed(level)


func _on_credits_pressed() -> void:
	get_tree().change_scene_to_file("res://scenet/credits.tscn")


func _on_exit_pressed() -> void:
	get_tree().quit()
	

func _on_settings_pressed() -> void:
	get_tree().change_scene_to_file("res://scenet/settings.tscn")
