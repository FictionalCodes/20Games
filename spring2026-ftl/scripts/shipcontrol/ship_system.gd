class_name ShipSystem extends RefCounted

var system_name: String

var max_power : int = 3
var current_power : int = 0
var current_HP : int = 3

var power_step : int = 1

var _powerRequest : Callable
var _powerReturn : Callable

signal power_update

func _init(powerRequestCallback: Callable, powerReturnCallback: Callable):
	_powerRequest = powerRequestCallback
	_powerReturn = powerReturnCallback
	
func step_power_up() -> void:
	if current_power < current_HP and current_power < max_power:
		if _powerRequest.call(power_step):
			current_power += power_step
			power_update.emit()

func step_power_down() -> void:
	if current_power > 0:
		_powerReturn.call(power_step)
		current_power -= power_step
		power_update.emit()
