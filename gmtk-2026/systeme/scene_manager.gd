extends Node

var current_scene: Node2D
var current_menu: Control
@export var level: Node2D
@export var gui: Control

func _ready() -> void:
	Global.game_controller = self
	gui = $GUI/Menu
	current_menu = gui.get_children().front()

func start(scene_path: String):
	var new = load(scene_path).instantiate()
	level.add_child(new)
	current_scene = new
	
func change_2D_scene(scene_path: String):
	current_scene.queue_free()
	var new = load(scene_path).instantiate()
	level.add_child(new)
	current_scene = new
	
func change_gui_scene(scene_path:String):
	current_menu.queue_free()
	var new = load(scene_path).instantiate()
	gui.add_child(new)
	current_menu = new

func quit():
	#Logique pour quitter le jeux 
	pass
