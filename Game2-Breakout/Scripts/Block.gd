class_name Block extends StaticBody2D



@export var hp := 1
var _startHP: int
var _colourIndex: int
var _onDestroyCallback : Callable

func setup_from_grid(newPosition: Vector2, startHP: int, colourIndex: int, on_destroy: Callable) -> void:
	position = newPosition
	hp = startHP
	_startHP = startHP
	_colourIndex = colourIndex
	_onDestroyCallback = on_destroy

func UpdateColourFromArray(colourArray: Array[Color]) -> void:
	modulate = colourArray[_colourIndex]

func on_hit() -> void:
	hp -= 1
	if hp <= 0:
		_onDestroyCallback.call(_startHP * (_colourIndex + 1))
		queue_free()
