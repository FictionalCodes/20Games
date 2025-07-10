class_name PlayerRespawnState extends PlayerDeadState

@export var respawnSafeArea : Area2D

func EnterState() -> void:
	super.EnterState()
	player.visible = true
