class_name Ennemy extends StaticBody2D

@export var data: EnnemyData
@onready var sprite_2d: Sprite2D = $Sprite2D
@onready var timer: Timer = $Timer

func _ready() -> void:
	sprite_2d.texture = data.sprite
	
	timer.wait_time = data.time_to_live * data.timer_step
	timer.one_shot = true
	timer.start()
	
	timer.connect("timeout", _enemy_timeout)
	
	data.add_letters(letters)

func _enemy_timeout():
	queue_free()

func kill():
	if data.kill:
		queue_free()
