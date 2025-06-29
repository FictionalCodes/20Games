class_name PlayerStateMachine extends StateMachine



func _ready() -> void:
	SwapStateImmediateKey(PlayerBaseState.PlayerState.Alive)
	
func _process(delta: float) -> void:
	Update(delta)
