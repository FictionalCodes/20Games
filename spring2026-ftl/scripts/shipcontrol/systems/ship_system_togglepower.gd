class_name ShipSystemToggle extends ShipSystemBase


var _powerRequest : Callable
var _powerReturn : Callable

func bind(powerRequestCallback: Callable, powerReturnCallback: Callable):
	_powerRequest = powerRequestCallback
	_powerReturn = powerReturnCallback
	step_power_up()
	
func step_power_up() -> void:
	if current_power < current_HP and current_power < max_power:
		if _powerRequest.call(power_step):
			current_power += power_step
			power_update.emit()

func step_power_down(amount: int = 0) -> void:
	if amount == 0:
		amount = power_step
	if current_power > 0:
		_powerReturn.call(amount)
		current_power -= amount
		power_update.emit()

func upgrade() -> bool:
	var result := super.upgrade()
	return result

func _set_current_hp(val: int) -> void:
	_real_hp = mini(val, max_power)
	if current_HP < current_power:
		step_power_down(current_power - current_HP)
	power_update.emit()

func initalise_system(newmax: int) -> void:
	super.initalise_system(newmax)
	current_power = 0
