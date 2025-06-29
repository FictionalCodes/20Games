class_name BaseState extends Node

func EnterState() -> void:
	process_mode = Node.PROCESS_MODE_INHERIT

func ExitState() -> void:
	process_mode = Node.PROCESS_MODE_DISABLED

func Update(_delta:float) -> int:
	return 0
