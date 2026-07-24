class_name Ennemy extends StaticBody2D

@export var data: EnnemyData

@onready var sprite_2d: Sprite2D = $Sprite2D
@onready var letter_btn: Node2D = $LetterBtn
@onready var timer: Node2D = $EnnemyTimer
var in_killzone: bool = false

var letters: Array

#variable de kill
var killed: bool = true 


#parametrage ennemie
func _ready() -> void:
	sprite_2d.texture = data.sprite
	sprite_2d.scale = Vector2(0.08,0.08)
	
	add_letters()
	timer.initiate_timer(data)


# supprime ennemie 
func _enemy_timeout():
	EnnemyManager.failed_to_kill.emit()
	kill_ennemy()


func kill_ennemy():
	letter_btn.hit()
	EnnemyManager.enemy_killed.emit(self)
	if not in_killzone:
		return
	LetterManager.add_letters(letters)
	EnnemyManager.ennemies.erase(letters)
	if EnnemyManager.ennemies.is_empty():
		EnnemyManager.change_scene.emit()
	queue_free()


#don de lettre à l'ennemie
func add_letters():
	data.letters = letters.duplicate()
	letter_btn.add_letter(letters.front())
 

func _on_ennemy_timer_is_in_killzone() -> void:
	in_killzone = true
