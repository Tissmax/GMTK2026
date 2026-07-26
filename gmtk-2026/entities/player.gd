extends Node2D
@onready var health_bar: HBoxContainer = $HealthBar
@onready var animation_player_staff: AnimationPlayer = $Arms/Staff/AnimationPlayerStaff
@onready var animation_player_clock: AnimationPlayer = $Arms/Clock/AnimationPlayerClock
@onready var hit_indicator: TextureRect = $HitIndicator
@onready var camera_2d: Camera2D = $Camera2D
@onready var score: Label = $Score


var lifes: int = 3
var current_score = 0

func lose_hp(amount: int):
	var tween = create_tween()
	tween.tween_property(hit_indicator, "modulate", Color(255,255,255,1),0.25)
	tween.tween_property(hit_indicator, "modulate", Color(255,255,255,0),0.25)
	camera_2d.shake()
	lifes -= amount
	health_bar.loose_hp()
	if lifes <= 0:
		Global.game_controller.change_2D_scene("res://scenes/GameOver.tscn")

func _ready() -> void:
	EnnemyManager.enemy_killed.connect(_on_enemy_killed)
	EnnemyManager.failed_to_kill.connect(_on_kill_fail)
	EnnemyManager.player_anim_hit.connect(_on_staff_anim_request)
	EnnemyManager.player_anim_flop.connect(_on_staff_anim_request)

	animation_player_clock.play("Tik")
	animation_player_staff.play("IdleStaff")
	
	score.text = str(current_score)

	
func _on_enemy_killed(enemy: Ennemy):	
	if enemy.in_killzone and  enemy.killed_by_player:
		current_score += 1
		score.text = str(current_score)
		
func _on_kill_fail():
	lose_hp(1)

func _on_staff_anim_request(miss: bool):
	if animation_player_staff.current_animation != "IdleStaff":
		return
	if miss:
		animation_player_staff.play("MissStaff")
	else:
		animation_player_staff.play("HitStaff")
		
	await animation_player_staff.animation_finished
	animation_player_staff.play("IdleStaff")
