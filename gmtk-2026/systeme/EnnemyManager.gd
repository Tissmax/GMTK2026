extends Node
const EnemyScene = preload("res://entities/ennemy.tscn")
const STANDARD = preload("res://ressources/basic.tres")
const RAPIDE = preload("res://ressources/fast.tres")


var ennemies: Dictionary[Array,Ennemy]
var timer: Timer
var spawn_points: Array[Marker2D]

signal player_anim_flop()
signal player_anim_hit()
signal enemy_killed(enemy: Ennemy)
signal failed_to_kill()

func spawn_ennemy(type: EnnemyData):
	var ennemy: Ennemy = EnemyScene.instantiate()
	ennemy.data = type
	_pick_spawn_point(ennemy)
	ennemy.letters = LetterManager.pick_letters(ennemy.data.multiple_letters)
	ennemies[ennemy.letters] = ennemy
	add_child(ennemy)

func _input(event: InputEvent) -> void:
	var keys = ennemies.keys()
	var keys_flat:Array
	for k in keys:
		keys_flat.append_array(k)
	if event is InputEventKey and event.pressed:
		var touche = to_array(event.as_text_key_label())
		if ennemies.has(touche):
			var ennemie = ennemies.get(touche)
			ennemie.killed_by_player = true
			ennemie.kill_ennemy()
		else:
			# Perte d'HP si mauvaise touche
			var current_ennemies = ennemies.values() as Array[Ennemy]
			player_anim_flop.emit()
			for ennemy in current_ennemies:
				ennemy.animation_player.play("flop")
			current_ennemies.front().flop.play()
			failed_to_kill.emit()
			
func to_array(strings:String)->Array:
	var array:Array
	array.push_back(strings)
	return array
	
func _pick_spawn_point(ennemy: Ennemy):
	var point = spawn_points.pick_random()
	ennemy.position = point.position
	spawn_points.erase(point)
	
