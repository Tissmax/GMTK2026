extends Node

var ennemies: Dictionary[Array,Ennemy]
var timer: Timer
var invul_timer: Timer
var can_lose_health: bool = true

signal player_anim_flop(miss: bool)
signal player_anim_hit(miss: bool)
signal enemy_killed(enemy: Ennemy)
signal failed_to_kill()

func _input(event: InputEvent) -> void:
	
	#Blocages des input si pas d'ennemies
	if ennemies.is_empty():
		return
	
	if event is InputEventKey and event.pressed:
		if !can_lose_health:
			return
			
		var keys = ennemies.keys()
		var keys_flat:Array
		for k in keys:
			keys_flat.append_array(k)
		
		trigger_invulnerability(1)
		
		var touche = to_array(event.as_text_key_label())
		if ennemies.has(touche):
			var ennemie = ennemies.get(touche)
			ennemie.killed_by_player = true
			ennemie.kill_ennemy()
		else:
			# Perte d'HP si mauvaise touche
			var current_ennemies = ennemies.values() as Array[Ennemy]
			player_anim_flop.emit(true)
			for ennemy in current_ennemies:
				ennemy.animation_player.play("flop")
			current_ennemies.front().flop.play()
			failed_to_kill.emit()
			
func to_array(strings:String)->Array:
	var array:Array
	array.push_back(strings)
	return array
	
	
func trigger_invulnerability(time_in_seconds: float):
	can_lose_health = false
	await get_tree().create_timer(time_in_seconds).timeout
	can_lose_health = true
