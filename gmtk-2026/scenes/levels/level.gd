class_name Level
extends Node2D

@onready var spawns = %SpawnPoints
@export var number_of_ennemies: int = 1
@export var ennemy_types: Array[EnnemyData]

var spawner = preload("res://scenes/levels/spawner.gd")

var spawn_points: Array[Marker2D]
var last_spawn: Marker2D

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	spawn_points.assign(spawns.get_children())
	
	spawner = spawner.new()
	spawner.spawns_left = number_of_ennemies
	spawner.types = ennemy_types
	spawner.last_ennemy_killed.connect(_on_last_ennemy_killed)
	add_child(spawner)
	
	spawner.start()
	
func _on_last_ennemy_killed():
	Global.game_controller.change_2D_scene()
