class_name PlayerDeadState extends PlayerBaseState


func EnterState() -> void:
	super.EnterState()
	player.freeze
