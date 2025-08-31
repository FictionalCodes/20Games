class_name MoveCommand extends RefCounted

var _targetPosition:= Vector2.ZERO

func _init(target_position: Vector2) -> void:
	_targetPosition = target_position

func get_target_position() -> Vector2:
	return _targetPosition
