class_name GameController extends Node

## The Game Controller controls the game. Not to be confused with an input device.

# constants
const EVENT_UI = preload("uid://drnu716wagmls")
const BEACON_MAP = preload("uid://b5jcq2ydeego5")
const SECTOR_MAP = preload("uid://3phvc8a387d2")

# @export variables
@export_category("Ship Layer")
@export var ship_scene_layer : CanvasLayer ## The Ship Layer.
@export var ship: ShipController ## The Ship Scene

@export_category("Event Layer")
@export var ui_layer: CanvasLayer ## The Event UI Layer.

# Regular variables
var beacon_map_ui: BeaconMap
var sector_map_ui: SectorMap


func _ready() -> void:
	_instantiate_beacon_map()
	_instantiate_sector_map()
	show_event_ui()


## Instantiate the beacon map
func _instantiate_beacon_map() -> void:
	beacon_map_ui = BEACON_MAP.instantiate()
	beacon_map_ui.show_sector_map.connect(_on_show_sector_map)
	ui_layer.add_child(beacon_map_ui)
	beacon_map_ui.hide()


## Instantiate the sector map
func _instantiate_sector_map() -> void:
	sector_map_ui = SECTOR_MAP.instantiate()
	sector_map_ui.close_sector_map_button.pressed.connect(_on_show_sector_map)
	ui_layer.add_child(sector_map_ui)
	sector_map_ui.hide()


## Show the Event UI
func show_event_ui() -> void:
	var event_ui = EVENT_UI.instantiate()
	ui_layer.add_child(event_ui)


func _on_show_sector_map() -> void:
	toggle_beacon_map_visible()
	toggle_sector_map_visible()


## Toggle Beacon Map visible
func toggle_beacon_map_visible() -> void:
	beacon_map_ui.visible = not beacon_map_ui.visible

## Toggle Sector Map visible
func toggle_sector_map_visible() -> void:
	sector_map_ui.visible = not sector_map_ui.visible
