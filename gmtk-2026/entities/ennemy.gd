class_name Ennemy extends StaticBody2D

@export var data: EnnemyData

@onready var sprite_2d: Sprite2D = $Sprite2D
@onready var timer: Timer = $Timer
@onready var loader: TextureProgressBar = $Loader
@onready var label: Label = $Label

var letters: Array

#variable de kill
var killed: bool = true 

func _process(_delta: float) -> void:
	loader.value = (timer.time_left / data.time_to_live) * 100

#parametrage ennemie
func _ready() -> void:
	sprite_2d.texture = data.sprite
	sprite_2d.scale = Vector2(0.08,0.08)
	
	timer.wait_time = data.time_to_live * data.timer_step
	timer.one_shot = true
	timer.start()
	timer.connect("timeout", _enemy_timeout)
	add_letters()


# supprime ennemie 
func _enemy_timeout():
	kill_ennemy()


func kill_ennemy():
	if not is_in_killzone(self):
		EnnemyManager.enemy_killed.emit(self, false)
		return
	LetterManager.add_letters(letters)
	EnnemyManager.ennemies.erase(letters)
	if EnnemyManager.ennemies.is_empty():
		EnnemyManager.change_scene.emit()
	EnnemyManager.enemy_killed.emit(self, true)
	queue_free()


#don de lettre à l'ennemie
func add_letters():
	data.letters = letters.duplicate()
	label.text = letters.front()


func _on_letter_timer_timeout() -> void:
	label.queue_free()

func is_in_killzone(ennemie:Ennemy):
	return ennemie.timer.time_left<ennemie.data.time_to_live * 0.2
