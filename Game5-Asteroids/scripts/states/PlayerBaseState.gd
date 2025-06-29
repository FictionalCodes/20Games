class_name PlayerBaseState extends BaseState

enum PlayerState{
	Alive = 1,
	Invunerable = 2,
	Dead = 3,
	Respawning = 4
}

@export var ThisState : PlayerState
@export var player: PlayerShip
	
func can_be_hurt() -> bool:
	return false
