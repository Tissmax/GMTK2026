extends HBoxContainer
var hearts: Array

func _ready() -> void:
	hearts = get_children()
	
func loose_hp():
	var last_heart = hearts.back()
	last_heart.loose_hp()
	hearts.erase(last_heart)
