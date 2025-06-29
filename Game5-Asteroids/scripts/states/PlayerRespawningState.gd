class_name PlayerRespawnState extends PlayerDeadState

@export var respawnSafeArea : Area2D

func Update(delta) -> int:
	if respawnSafeArea.get_overlapping_bodies().is_empty():
		return PlayerState.Invunerable
	
	return ThisState
