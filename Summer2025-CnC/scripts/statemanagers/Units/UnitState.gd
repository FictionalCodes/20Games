class_name UnitState extends Node

enum UnitState{
	Idle = 1,
	Moving = 2,
	Attacking = 3,
	Spawning = 4,
	Dead = 5
}

@export var ThisState : UnitState
@export var unit: BaseUnit

func can_be_hurt() -> bool:
	return false

func can_shoot() -> bool:
	return true
