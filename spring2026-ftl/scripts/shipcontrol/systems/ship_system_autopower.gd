class_name ShipSystemAutoPower extends ShipSystemBase

func _init(name: String, type: ShipSystemTypes) -> void:
	super._init(name, type)
	set_to_max()

func upgrade() -> bool:
	var result := super.upgrade()
	set_to_max()
	return result

func set_to_max() -> void:
	current_power = max_power

func initalise_system(newmax: int) -> void:
	super.initalise_system(newmax)
	set_to_max()
