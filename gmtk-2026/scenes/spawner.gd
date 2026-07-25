extends Node

@export var types: Array[EnnemyData]
@export var next_scene: String
@onready var spawn_points: Node = %SpawnPoints
var timer:Timer
var nb_spawns: int = 0
var total_spawns: int = 0
var ennemies_alive: int = 0
var spawned: int = 0
var killed: int = 0

func _ready():
	timer = Timer.new()
	timer.one_shot = true
	add_child(timer)
	timer.timeout.connect(_on_timer_timeout)
	timer.start(1)
	get_spawn_points()
	EnnemyManager.enemy_killed.connect(_on_enemy_killed)
	total_spawns = nb_spawns

func _on_enemy_killed(_enemy: Ennemy):
	killed += 1
	ennemies_alive -= 1
	if killed == total_spawns and ennemies_alive == 0:
		Global.game_controller.change_2D_scene(next_scene)

func _on_timer_timeout():

	if nb_spawns <= 0:
		return

	EnnemyManager.spawn_ennemy(types.pick_random())
	spawned += 1
	ennemies_alive += 1
	nb_spawns -= 1

	if nb_spawns > 0:
		timer.start(randf_range(1.5, 3.0))
	
func get_spawn_points():
	EnnemyManager.spawn_points.clear()
	nb_spawns = 0
	for point in spawn_points.get_children():
		nb_spawns += 1
		if point is Marker2D:
			EnnemyManager.spawn_points.append(point)
