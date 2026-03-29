class_name ShipController extends Node


@export var total_power : int = 10
@export var power_avalible : int:
	get: return power_avalible
	set(val): 
		power_avalible = val
		power_updated.emit(power_avalible, total_power)
		
@export var total_HP : int
@export var current_HP : int : 
	get: return current_HP
	set(val): 
		current_HP = val
		hp_updated.emit(current_HP)

@onready var overlay : ShipOverlay = $CanvasLayer/ShipUiOverlay

signal hp_updated
signal power_updated

func _ready() -> void:
	create_base_systems()
	power_updated.connect(overlay.ship_reactor_display.update_display)

func get_power(amount: int = 1) -> bool:
	if power_avalible >= amount:
		power_avalible -= amount
		return true
	return false

func return_power(amount: int = 1) -> void:
	power_avalible += amount if power_avalible + amount < total_power else 0

func create_base_systems() -> void:
	overlay.add_system(ShipSystemHelpers.CreateAutoPowerSystem("Pilot", ShipSystemBase.ShipSystemTypes.PILOT))
	overlay.add_system(ShipSystemHelpers.CreateAutoPowerSystem("Sensors", ShipSystemBase.ShipSystemTypes.SENSORS))
	overlay.add_system(ShipSystemHelpers.CreateAutoPowerSystem("Doors", ShipSystemBase.ShipSystemTypes.DOORS))
	
	overlay.add_system(ShipSystemHelpers.CreateTogglePowerSystem("Oxygen", ShipSystemBase.ShipSystemTypes.OXY, get_power, return_power))
	overlay.add_system(ShipSystemHelpers.CreateTogglePowerSystem("Engine", ShipSystemBase.ShipSystemTypes.ENGINE, get_power, return_power))
	overlay.add_system(ShipSystemHelpers.CreateShieldSystem(get_power, return_power))
