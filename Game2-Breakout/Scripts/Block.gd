class_name Block extends StaticBody2D



@export var hp := 1
var _onDestroyCallback : Callable

func setup_from_grid(newPosition: Vector2, colour : Color, newHP: int, on_destroy: Callable) -> void:
	position = newPosition
	modulate = colour
	hp = newHP
	_onDestroyCallback = on_destroy


func on_hit() -> void:
	hp -= 1
	if hp <= 0:
		_onDestroyCallback.call()
		queue_free()
