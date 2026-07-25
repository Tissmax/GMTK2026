extends Node2D
@onready var health_bar: HBoxContainer = $HealthBar
@onready var animation_player_staff: AnimationPlayer = $Arms/Staff/AnimationPlayerStaff
@onready var animation_player_clock: AnimationPlayer = $Arms/Clock/AnimationPlayerClock


var lifes: int = 3
var score: int

func lose_hp(amount: int):
	lifes -= amount
	health_bar.loose_hp()

func _ready() -> void:
	EnnemyManager.enemy_killed.connect(_on_enemy_killed)
	EnnemyManager.failed_to_kill.connect(_on_kill_fail)
	EnnemyManager.player_anim_hit.connect(_on_hit)
	EnnemyManager.player_anim_flop.connect(_on_flop)

	animation_player_clock.play("Tik")
	animation_player_staff.play("IdleStaff")

	
func _on_enemy_killed(enemy: Ennemy):	
	if enemy.in_killzone and  enemy.killed_by_player:
		score += 1
		
func _on_kill_fail():
	lose_hp(1)

func _on_flop():
	animation_player_staff.play("MissStaff")
	await animation_player_staff.animation_finished
	animation_player_staff.play("IdleStaff")


func _on_hit():
	animation_player_staff.play("HitStaff")
	await animation_player_staff.animation_finished
	animation_player_staff.play("IdleStaff")
