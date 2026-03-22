class_name ShipSystemUI extends Control

var system : ShipSystem = null

@onready var curr_power : Label = $CurrentPowerLabel
@onready var max_power : Label = $MaxPowerLabel
@onready var system_name : Label = $System_Name
func _ready() -> void:
	system_name.text = system.system_name
	update_gui()

func _on_gui_input(event: InputEvent) -> void:
	
	if event is InputEventMouseButton:
		var mouseButtonEvent = event as InputEventMouseButton
		if !mouseButtonEvent.pressed:
			return
		match mouseButtonEvent.button_index:
			MouseButton.MOUSE_BUTTON_LEFT:
				system.step_power_up()
			MouseButton.MOUSE_BUTTON_RIGHT:
				system.step_power_down()
			_:
				return

func update_gui() -> void:
	curr_power.text = "Current Power - %s" % system.current_power
	max_power.text = "Max Power - %s" % system.max_power
