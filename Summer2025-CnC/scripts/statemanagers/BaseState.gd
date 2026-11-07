class_name BaseState extends Node2D

func EnterState() -> void:
	process_mode = Node.PROCESS_MODE_INHERIT

func ExitState() -> void:
	process_mode = Node.PROCESS_MODE_DISABLED

func Update(delta:float) -> int:
	return 0

func can_shoot() -> bool:
	return false
