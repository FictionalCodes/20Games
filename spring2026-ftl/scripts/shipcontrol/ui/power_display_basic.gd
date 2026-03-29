class_name PowerDisplayBasic extends Container

@onready var curr_power : Label = $CurrentPowerLabel
@onready var max_power : Label = $MaxPowerLabel


func update_display(current: int, max: int) -> void:
	curr_power.text = "Current Power - %s" % current
	max_power.text = "Max Power - %s" % max
