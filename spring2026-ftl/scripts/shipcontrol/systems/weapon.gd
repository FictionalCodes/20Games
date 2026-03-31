class_name ShipWeapon extends RefCounted

var weapon_data : WeaponData
var active : bool
var auto_fire : bool

var charge_amount : float = 0
var charged : bool :
	get: return floori(charge_amount)

func _init(data : WeaponData) -> void:
	weapon_data = data
	
func update(delta: float) -> void:
	if charge_amount < 1.0:
		charge_amount += delta / weapon_data.secs_to_charge
	
