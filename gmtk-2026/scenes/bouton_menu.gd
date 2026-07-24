extends VBoxContainer

func _on_play_pressed() -> void:
	Global.game_controller.change_gui_scene("res://scenes/InGameGui.tscn")
	Global.game_controller.start("res://scenes/Forest1.tscn")


func _on_quit_pressed() -> void:
	pass # Replace with function body.
