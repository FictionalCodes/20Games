class_name PlayerStateMachine extends StateMachine

@export var startingState := PlayerBaseState.PlayerState.Respawning

func _ready() -> void:
	QueueSwapState(startingState)
	
func _process(delta: float) -> void:
	Update(delta)
