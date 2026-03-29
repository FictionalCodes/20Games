class_name ShipOverlay extends Container

@export var systemBaseUI : PackedScene

@export var _systems_container_left: HBoxContainer
@export var _systems_container_right: HBoxContainer
@export var ship_reactor_display: Control

@export var fuel_display : ResourceDisplay
@export var missiles_display : ResourceDisplay
@export var drones_display : ResourceDisplay
@export var hp_display : ResourceDisplay
@export var scrap_display : ResourceDisplay

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass # Replace with function body.

func update_status(ship: ShipController) -> void:
	fuel_display.amount = ship.fuel
	missiles_display.amount = ship.missiles
	drones_display.amount = ship.robots
	hp_display.amount = ship.current_HP
	scrap_display.amount = ship.scrap

func add_system(system: ShipSystemBase):
	var systemUI : ShipSystemUI = systemBaseUI.instantiate()
	systemUI.system = system
	system.power_update.connect(systemUI.update_gui)
	
	if system is ShipSystemToggle:
		_systems_container_left.add_child(systemUI)
	else:
		_systems_container_right.add_child(systemUI)
