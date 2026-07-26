extends CanvasLayer

func _on_retry_pressed() -> void:
	Global.game_controller.change_2D_scene("res://scenes/Forest1.tscn")
