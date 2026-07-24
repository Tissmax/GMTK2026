extends Node2D
@onready var animation_player: AnimationPlayer = $AnimationPlayer

func loose_hp():
	animation_player.play("Heart_Dmg")

func idle_hp():
	animation_player.play("Heartfull")
