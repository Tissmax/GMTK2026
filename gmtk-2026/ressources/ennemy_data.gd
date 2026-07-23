class_name EnnemyData extends Resource

@export var time_to_live: float = 0.0
@export var timer_step: float = 1.0
@export var is_timer_visible: bool = true
@export var sprite: Texture2D
@export var multiple_letters: bool = false
var letters: Array[String]
var kill: bool = false

func add_letters(letters: Array[String]):
	letters = letters

func is_letter_correct(letter: String) -> bool:
	var has_letter = letters.has(letter)
	if has_letter:
		letters.filter(func (l): return l != letter)
	if letters.is_empty():
		kill = true
	return has_letter
