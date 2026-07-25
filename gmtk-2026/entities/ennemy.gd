class_name Ennemy extends StaticBody2D

@export var data: EnnemyData

@onready var sprite_2d: Sprite2D = $Sprite2D
@onready var letter_btn: Node2D = $LetterBtn
@onready var timer: Node2D = $EnnemyTimer
@onready var animation_player: AnimationPlayer = $AnimationPlayer
@onready var flop: AudioStreamPlayer = $Sounds/Flop
@onready var spawn: AudioStreamPlayer = $Sounds/Spawn

var in_killzone: bool = false

var letters: Array

#variable de kill
var killed_by_player: bool = false 


#parametrage ennemie
func _ready() -> void:
	add_letters()
	timer.initiate_timer(data)
	animation_player.play("idle")
	_init_shader()
	spawn.play()

# supprime ennemie 
func _enemy_timeout():
	EnnemyManager.failed_to_kill.emit()
	animation_player.play("quit")
	kill_ennemy()


func kill_ennemy():
	letter_btn.hit()
	if not in_killzone:
		EnnemyManager.failed_to_kill.emit()
		animation_player.play("flop")
		flop.play()
	else:
		animation_player.play("death")
		
	await animation_player.animation_finished
	
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
