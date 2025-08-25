class_name UnitBaseState extends BaseState

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
	return true

func can_shoot() -> bool:
	return true

func Update(delta: float) -> int:
	unit.currentCommand
