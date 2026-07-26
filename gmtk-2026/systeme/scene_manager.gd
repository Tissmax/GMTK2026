extends Node

var current_level: Level
var current_menu: Control
@export var level: Node2D
@export var gui: Control
@export var levels_path: Array[String]

var last_scene: String


func _ready() -> void:
	Global.game_controller = self
	gui = $GUI/Menu
	current_menu = gui.get_children().front()

func start(scene_path: String):
	var new = load(scene_path).instantiate()
	level.add_child(new)
	current_level = new as Level
	
func change_2D_scene():
	var scene_path = levels_path.pick_random()
	while scene_path == last_scene:
		scene_path = levels_path.pick_random()
		
	current_level.queue_free()
	var new = load(scene_path).instantiate()
	level.add_child(new)
	
	current_level = new as Level
	last_scene = scene_path
	
func change_gui_scene(scene_path:String):
	current_menu.queue_free()
	var new = load(scene_path).instantiate()
	gui.add_child(new)
	current_menu = new

func quit():
	#Logique pour quitter le jeux 
	pass
	
func get_spawn_points() -> Array[Marker2D]:
	return current_level.spawn_points
	
func erase_point(point: Marker2D):
	current_level.spawn_points.erase(point)
