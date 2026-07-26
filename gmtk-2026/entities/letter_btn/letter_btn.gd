extends Node2D


@onready var animation_player: AnimationPlayer = $AnimationPlayer
@onready var label: Label = $Label
@onready var sprite: Sprite2D = $Sprite

func add_letter(letter: String):
	label.text = letter
	
func hit():
	animation_player.play("pressed")


func _on_letter_timer_timeout() -> void:
	label.queue_free()
	
func set_shader():
	var mat: ShaderMaterial  = sprite.material 
	mat.set_shader_parameter("active", true)
