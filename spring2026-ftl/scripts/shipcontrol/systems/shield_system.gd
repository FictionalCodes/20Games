class_name ShieldSystem extends ShipSystemToggle

var shield_number_max: int = 1
var shield_number_current: int = 1:
	get: return shield_number_current
	set(val):
		shield_number_current = mini(val, shield_number_max)
		shields_updated.emit(shield_number_current, recharging)

var recharging : bool :
	get: return shield_number_current < shield_number_max
var recharge_amount : float = 0.05

signal shields_updated(new_number: int, recharging: bool)

func _init(name: String, type: ShipSystemTypes) -> void:
	super._init(name, type)
	power_step = 2
	
	power_update.connect(update_shielding, ConnectFlags.CONNECT_DEFERRED)

func update_shielding() -> void:
	@warning_ignore("integer_division")
	shield_number_max = shield_number_max / 2
	shield_number_current = mini(shield_number_current, shield_number_max)

var recharge_counter : float = 0.0
func update(delta: float) -> void:
	if recharging:
		recharge_counter += delta
		if recharge_counter > recharge_time:
			shield_number_current += 1
	else:
		recharge_counter = 0

func pop_shield() -> void:
	shield_number_current -= 1
	
