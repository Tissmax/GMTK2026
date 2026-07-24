extends Node2D


@onready var animation_player: AnimationPlayer = $AnimationPlayer
@onready var label: Label = $Label

func add_letter(letter: String):
	label.text = letter
	
func hit():
	animation_player.play("pressed")


func _on_letter_timer_timeout() -> void:
	label.queue_free()
