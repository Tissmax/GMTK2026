extends Node
const EnemyScene = preload("res://entities/ennemy.tscn")
const GHOST = preload("res://ressources/ghost.tres")
const LINGUISTE = preload("res://ressources/linguiste.tres")
const RAPIDE = preload("res://ressources/rapide.tres")
const STANDARD = preload("res://ressources/standard.tres")
var ennemies: Dictionary[Array,Ennemy]
var timer: Timer
var spawn_points: Array[Marker2D]

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
			ennemie.kill_ennemy()
		else:
			failed_to_kill.emit()
			
func to_array(strings:String)->Array:
	var array:Array
	array.push_back(strings)
	return array
	
func _pick_spawn_point(ennemy: Ennemy):
	var point = spawn_points.pick_random()
	ennemy.position = point.position
	spawn_points.erase(point)
	
