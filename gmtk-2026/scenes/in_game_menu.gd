extends Control
@onready var animation_player: AnimationPlayer = $"AnimationPlayer"
@onready var in_game_menu: VBoxContainer = $InGameMenu
		
func _on_pause_pressed() -> void:
	pause()

func _on_resume_pressed() -> void:
	resume()
	
func _on_quit_pressed() -> void:
	Global.game_controller.quit()
	
func resume():
	get_tree().paused = false
	in_game_menu.hide()
	animation_player.play_backwards("blur")

func pause():
	get_tree().paused = true
	in_game_menu.show()
	animation_player.play("blur")
	
	
