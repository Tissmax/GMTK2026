class_name Ennemy extends StaticBody2D

@export var data: EnnemyData
@onready var sprite_2d: Sprite2D = $Sprite2D
@onready var timer: Timer = $Timer
var letters: Array[String]
#variable de kill
var kill: bool = false 

#parametrage ennemie
func _ready() -> void:
	sprite_2d.texture = data.sprite
	
	timer.wait_time = data.time_to_live * data.timer_step
	timer.one_shot = true
	timer.start()
	timer.connect("timeout", _enemy_timeout)
	add_letters()
# supprime ennemie 
func _enemy_timeout():
	queue_free()

func kill_ennemy():
	if kill:
		queue_free()

#don de lettre à l'ennemie
func add_letters():
	data.letters = letters
	

#verifier que input utilisateur correspond a input ennemie
func is_letter_correct(letter: String) -> bool:
	var has_letter = data.letters.has(letter)
	if has_letter:
		data.letters.filter(func (l): return l != letter)
	if data.letters.is_empty():
		kill = true
	return has_letter
