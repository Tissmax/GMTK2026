extends Camera2D


@export var duration: float = 0.5
@export var strength: float = 50.0
var tw: Tween = null

func shake():
	var base_offset = offset
	if tw: tw.kill()
	tw = get_tree().create_tween()
	tw.tween_method(func (delay: float):
		var movement = Vector2(
			randf_range(-1.0, 1.0), randf_range(-1.0, 1.0) * strength * delay
			)
		offset = base_offset + movement, 1.0, 0.0, duration
		)
	
