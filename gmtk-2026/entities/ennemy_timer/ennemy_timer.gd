extends Node2D

@onready var timer: Timer = $Timer
@onready var animation_player: AnimationPlayer = $AnimationPlayer
@onready var sprite_2d: Sprite2D = $Sprite2D

var color: Color

signal ennemy_timeout
signal is_in_killzone
# Called when the node enters the scene tree for the first time.
func initiate_timer(data: EnnemyData) -> void:
	timer.wait_time = data.time_to_live
	timer.one_shot = true
	timer.connect("timeout", _timeout)

	animation_player.speed_scale = data.timer_step
	animation_player.play("timer")
	timer.start()
	
func _timeout():
	ennemy_timeout.emit()

func _is_in_kill_zone():
	var mat: ShaderMaterial  = sprite_2d.material 
	mat.set_shader_parameter("active", true)
	is_in_killzone.emit()
