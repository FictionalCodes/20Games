class_name ShipSystemBase extends RefCounted

enum ShipSystemTypes
{
	PILOT,
	SENSORS,
	DOORS,
	SHIELDS,
	ENGINE,
	WEAPONS,
	OXY,
	MEDICAL,
	DRONE,
}

var system_type: ShipSystemTypes
var system_name: String

var max_upgrade_level : int = 3

var max_power : int = 1
var current_power : int = 0:
	get: return current_power
	set(val): 
		current_power = mini(val, max_power)
		power_update.emit()
var _real_hp : int = max_power
var current_HP : int = max_power:
	get: return _real_hp
	set(val): 
		_set_current_hp(val)
		
var power_step : int = 1

signal power_update

var current_operational_level: int:
	get: return mini(current_HP, current_power)

func _init(name: String, type: ShipSystemTypes) -> void:
	system_name = name
	system_type = type

func initalise_system(newmax: int) -> void:
	max_power = newmax
	current_HP = newmax

func upgrade() -> bool:
	if max_power < max_upgrade_level: 
		max_power += 1
		current_HP += 1
		power_update.emit()
		return true
	return false


func _set_current_hp(val: int) -> void:
	_real_hp = mini(val, max_power)
	power_update.emit()
