extends Node

signal PlayerDied()
signal GameOver()
signal NewStage()
signal NewLevel()

enum EventName {
	PlayerDied,
	GameOver,
	NewStage,
	NewLevel,
}

var signal_map = {
	EventName.PlayerDied: PlayerDied,
	EventName.GameOver: GameOver,
	EventName.NewStage: NewStage,
	EventName.NewLevel: NewLevel

}

func subscribe(event : EventName, callback: Callable, differ: bool = false) -> bool:
	if signal_map.has(event):
		signal_map[event].connect(callback, CONNECT_DEFERRED if differ else 0)

		return true
	else:
		return false

func invoke(event : EventName, args: Array = []) -> bool:
	if signal_map.has(event):
		var found : Signal = signal_map[event].emit(args)
		return true
	else:
		return false
