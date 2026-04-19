class_name EngineSystem extends ShipSystemToggle

var chargerate: float = 0.02
var upgrade_chargerate_bonus : float = 0.1
var charge_current: float = 0:
	get: return charge_current
	set(val):
		charge_current = minf(val, 1.0)
		charge_updated.emit(charge_current)

var recharging : bool :
	get: return floori(charge_current)

signal charge_updated(new_percent: float)

var recharge_counter : float = 0.0
func update(delta: float) -> void:
	charge_current = ((chargerate * current_operational_level) + (upgrade_chargerate_bonus * max_power)) * delta
	
func jumped() -> void:
	charge_current = 0
	
	
