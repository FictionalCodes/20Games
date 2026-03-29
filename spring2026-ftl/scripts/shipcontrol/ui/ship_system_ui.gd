class_name ShipSystemUI extends PowerDisplayBasic

var system : ShipSystemBase = null

@onready var system_name : Label = $System_Name
func _ready() -> void:
	system_name.text = system.system_name
	if system is ShipSystemToggle:
		gui_input.connect(_on_gui_input, ConnectFlags.CONNECT_DEFERRED)
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
	update_display(system.current_operational_level, system.max_power)

func _on_button_pressed() -> void:
	system.upgrade()
