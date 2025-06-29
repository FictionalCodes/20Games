class_name PlayerBaseState extends BaseState

enum PlayerState{
	Alive = 1,
	Invunerable = 2,
	Dead = 3
}

@export var ThisState : PlayerState
@export var player: PlayerShip
	
