extends Button

signal hide_beacon_map

# Export Variables
@export var beacon_map : BeaconMap


func _ready() -> void:
	hide_beacon_map.connect(beacon_map.hide_beacon_map)
	pressed.connect(_on_button_pressed)


func _on_button_pressed() -> void:
	hide_beacon_map.emit()
