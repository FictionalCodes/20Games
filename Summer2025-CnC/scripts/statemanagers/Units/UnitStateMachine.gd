class_name UnitStateMachine extends StateMachine


var currentCommand : BaseCommand = null
var _queuedCommands : Array[BaseCommand] = []

@export var startingState := UnitBaseState.UnitState.Idle

func _ready() -> void:
	QueueSwapState(startingState)
	
func _process_physics(delta: float) -> void:
	Update(delta)
