class_name AttackCommand extends BaseCommand

var _target: Node2D = null

func _init(target_entity: Node2D) -> void:
	_target = target_entity

func get_target_position() -> Vector2:
	return _target.global_position
