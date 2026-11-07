class_name ShipWeapon extends RefCounted

var weapon_data : WeaponData
var active : bool:
	get: return active
	set(on):
		if !on:
			charge_amount = 0
			
		active = on
		weapon_power_toggle.call_deferred(on)
		update_ui.emit(self)
		
var auto_fire : bool

var charge_amount : float = 0
var charged : bool :
	get: return floori(charge_amount)
	
signal update_ui(weapon: ShipWeapon)
var weapon_power_toggle: Callable
func _init(data : WeaponData, weaponOnOff: Callable) -> void:
	weapon_data = data
	weapon_power_toggle = weaponOnOff
	
func update(delta: float) -> void:
	if active and charge_amount < 1.0:
		charge_amount += delta / weapon_data.secs_to_charge
		update_ui.emit(self)
	
