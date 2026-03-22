extends MarginContainer

@export var systemBaseUI : PackedScene

@onready var systems_container = $SystemsContainer

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass # Replace with function body.


func add_system(system: ShipSystem):
	var systemUI : ShipSystemUI = systemBaseUI.instantiate()
	systemUI.system = system
	system.power_update.connect(systemUI.update_gui)
	systems_container.add_child(systemUI)
