extends Node2D
@onready var health_bar: HBoxContainer = $HealthBar

var lifes: int = 3
var score: int

func lose_hp(amount: int):
	lifes -= amount
	health_bar.loose_hp()

func _ready() -> void:
	EnnemyManager.enemy_killed.connect(_on_enemy_killed)
	EnnemyManager.failed_to_kill.connect(_on_kill_fail)
	
func _on_enemy_killed(enemy: Ennemy):	
	if enemy.in_killzone:
		score += 1
		
func _on_kill_fail():
	lose_hp(1)
