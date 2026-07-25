class_name Ennemy extends StaticBody2D

@export var data: EnnemyData

@onready var sprite_2d: Sprite2D = $Sprite2D
@onready var letter_btn: Node2D = $LetterBtn
@onready var timer: Node2D = $EnnemyTimer
@onready var animation_player: AnimationPlayer = $AnimationPlayer
var in_killzone: bool = false

var letters: Array

#variable de kill
var killed: bool = true 


#parametrage ennemie
func _ready() -> void:
	sprite_2d.texture = data.sprite
	add_letters()
	timer.initiate_timer(data)
	animation_player.play("idle")
	_init_shader()

# supprime ennemie 
func _enemy_timeout():
	EnnemyManager.failed_to_kill.emit()
	kill_ennemy()


func kill_ennemy():
	letter_btn.hit()
	if not in_killzone:
		EnnemyManager.failed_to_kill.emit()
		# TODO Animation de fail
	else:
		#TODO Animation de mort
		pass
		
	EnnemyManager.enemy_killed.emit(self)
	LetterManager.add_letters(letters)
	EnnemyManager.ennemies.erase(letters)
	
	queue_free()


#don de lettre à l'ennemie
func add_letters():
	data.letters = letters.duplicate()
	letter_btn.add_letter(letters.front())
 

func _on_ennemy_timer_is_in_killzone() -> void:
	in_killzone = true
	
func _init_shader():
	var shader := sprite_2d.material as ShaderMaterial
	if shader:
		shader.set_shader_parameter("new_color", data.color)
		shader.set_shader_parameter("new_shadow", data.shadow)
