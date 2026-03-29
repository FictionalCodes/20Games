class_name ShipOverlay extends Container

@export var systemBaseUI : PackedScene

@export var _systems_container_left: HBoxContainer
@export var _systems_container_right: HBoxContainer
@export var ship_reactor_display: Control

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass # Replace with function body.


func add_system(system: ShipSystemBase):
	var systemUI : ShipSystemUI = systemBaseUI.instantiate()
	systemUI.system = system
	system.power_update.connect(systemUI.update_gui)
	
	if system is ShipSystemToggle:
		_systems_container_left.add_child(systemUI)
	else:
		_systems_container_right.add_child(systemUI)
