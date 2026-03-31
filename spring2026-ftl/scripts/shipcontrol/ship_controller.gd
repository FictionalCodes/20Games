class_name ShipController extends Node


@export var total_power : int = 10
@export var power_avalible : int:
	get: return power_avalible
	set(val): 
		power_avalible = val
		_power_updated.emit(power_avalible, total_power)
		
@export var total_HP : int
@export var current_HP : int : 
	get: return current_HP
	set(val): 
		current_HP = val
		hp_updated.emit(current_HP)
		

@export var fuel : int : 
	get: return fuel
	set(val): 
		fuel = val
		_resources_updated.emit(self)
@export var missiles : int : 
	get: return missiles
	set(val): 
		missiles = val
		_resources_updated.emit(self)
@export var robots : int : 
	get: return robots
	set(val): 
		robots = val
		_resources_updated.emit(self)
@export var scrap : int : 
	get: return scrap
	set(val): 
		scrap = val
		_resources_updated.emit(self)


@onready var _overlay : ShipOverlay = $CanvasLayer/ShipUiOverlay

var _systems: Dictionary[ShipSystemBase.ShipSystemTypes, ShipSystemBase] = {}

var is_dead : bool:
	get: return current_HP <= 0

signal hp_updated
signal _power_updated
signal _resources_updated

func _ready() -> void:
	power_avalible = total_power
	_create_base_systems()
	_power_updated.connect(_overlay.ship_reactor_display.update_display, ConnectFlags.CONNECT_DEFERRED)
	_resources_updated.connect(_overlay.update_status, ConnectFlags.CONNECT_DEFERRED)
	_resources_updated.emit(self)
	_power_updated.emit(power_avalible, total_power)

func get_power(amount: int = 1) -> bool:
	if power_avalible >= amount:
		power_avalible -= amount
		return true
	return false

func return_power(amount: int = 1) -> void:
	power_avalible += amount if power_avalible + amount < total_power else 0

func _create_base_systems() -> void:
	add_system(ShipSystemHelpers.CreateAutoPowerSystem("Pilot", ShipSystemBase.ShipSystemTypes.PILOT))
	add_system(ShipSystemHelpers.CreateAutoPowerSystem("Sensors", ShipSystemBase.ShipSystemTypes.SENSORS))
	add_system(ShipSystemHelpers.CreateAutoPowerSystem("Doors", ShipSystemBase.ShipSystemTypes.DOORS))
	
	add_system(ShipSystemHelpers.CreateTogglePowerSystem("Oxygen", ShipSystemBase.ShipSystemTypes.OXY, get_power, return_power))
	add_system(ShipSystemHelpers.CreateTogglePowerSystem("Engine", ShipSystemBase.ShipSystemTypes.ENGINE, get_power, return_power))
	add_system(ShipSystemHelpers.CreateShieldSystem(get_power, return_power))
	
func add_system(systype: ShipSystemBase) -> void:
	_overlay.add_system(systype)
	
	_systems[systype.system_type] = systype

func get_system(systype: ShipSystemBase.ShipSystemTypes) -> void:
	return _systems.get(systype)

func _process(delta: float) -> void:
	for sys in _systems.values():
		sys.update(delta)

func jumped() -> void:
	for sys in _systems.values():
		sys.jumped()
