class_name Spawner
extends Node


const EnemyScene = preload("res://entities/ennemy.tscn")

var types: Array[EnnemyData]
var timer:Timer
var spawns_left: int = 0
var ennemies_alive: int = 0
var spawned: int = 0
var cannot_spawn: bool

signal last_ennemy_killed

func start():
	timer = Timer.new()
	timer.one_shot = true
	add_child(timer)
	timer.timeout.connect(_on_timer_timeout)
	timer.start(1)
	EnnemyManager.enemy_killed.connect(_on_enemy_killed)
	
func _on_enemy_killed(_enemy: Ennemy):
	ennemies_alive -= 1
	if ennemies_alive == 0 and spawns_left == 0:
		last_ennemy_killed.emit()

func _on_timer_timeout():
	if spawns_left <= 0:
		return

	spawn_ennemy(types.pick_random())
	spawned += 1
	ennemies_alive += 1
	spawns_left -= 1

	if spawns_left > 0:
		timer.start(randf_range(1.5, 3.0))
	
func spawn_ennemy(type: EnnemyData):
	var ennemy: Ennemy = EnemyScene.instantiate()
	ennemy.data = type
	
	var point: Marker2D = await _get_available_spawn_point()
	
	ennemy.position = point.position
	ennemy.letters = LetterManager.pick_letters(ennemy.data.multiple_letters)
	EnnemyManager.ennemies[ennemy.letters] = ennemy
	add_child(ennemy)
	
func _get_available_spawn_point():
	var all_points = Global.game_controller.get_spawn_points()
	
	while true:
		var ennemies_pos: Array[Vector2] = []
		
		for e in EnnemyManager.ennemies.values():
			if is_instance_valid(e):
				ennemies_pos.append(e.position)
				
		var available_points: Array[Marker2D] = []
		
		for p in all_points:
			if p.position not in ennemies_pos:
				available_points.append(p)
				
		if available_points.size() > 0:
			return available_points.pick_random()
			
		await get_tree().create_timer(1.0).timeout
