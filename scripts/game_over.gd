extends Node2D



func _ready():
	var value_label = get_tree().root.get_node("GameOver/CanvasLayer/Menu/Score/Value")
	value_label.text = str(Global.score)
	Input.set_mouse_mode(Input.MOUSE_MODE_VISIBLE)

func _on_quit_button_pressed():
	get_tree().quit()


func _on_restart_button_pressed():
	get_tree().change_scene_to_file("res://scenes/world.tscn")
	Input.set_mouse_mode(Input.MOUSE_MODE_HIDDEN)
