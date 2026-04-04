class_name ShipWeaponsUI extends ShipSystemUI


# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	system_name = $ShipSystemUi/System_Name
	update_gui()



@warning_ignore("unused_parameter")
func _on_gui_input(event: InputEvent) -> void:
	pass
