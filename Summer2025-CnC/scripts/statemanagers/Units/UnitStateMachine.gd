class_name UnitStateMachine extends StateMachine

@export var startingState := UnitState.UnitState.Idle

func _ready() -> void:
	QueueSwapState(startingState)
	
func _process(delta: float) -> void:
	Update(delta)
