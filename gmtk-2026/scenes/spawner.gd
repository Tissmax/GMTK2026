extends Node

@export var types: Array[EnnemyData]
@export var next_scene: String
@onready var spawn_points: Node = %SpawnPoints
var timer:Timer
var nb_spawns: int

func _ready():
	timer = Timer.new()
	add_child(timer)
	timer.wait_time = 2
	timer.start()
	timer.timeout.connect(_on_timer_timeout)
	get_spawn_points()
	EnnemyManager.change_scene.connect(_on_last_ennemy_killed)

func _on_timer_timeout():
	print(types)
	if nb_spawns > 0:
		EnnemyManager.spawn_ennemy(types.pick_random())
	nb_spawns -= 1
	timer.wait_time = randf_range(1.5,3)
	
func get_spawn_points():
	var points = spawn_points.get_children()
	nb_spawns = points.size()

	for point in points:
		if point is Marker2D:
			EnnemyManager.spawn_points.append(point)
	
func _on_last_ennemy_killed():
	Global.game_controller.change_2D_scene(next_scene)
