class_name GameController extends Node

## The Game Controller controls the game. Not to be confused with an input device.

# signals
# enums
# constants
const EVENT_UI = preload("uid://drnu716wagmls")
const BEACON_MAP = preload("uid://b5jcq2ydeego5")

# static variables
# @export variables
@export_category("Ship Layer")
@export var ship_scene_layer : CanvasLayer ## The Ship Layer.
@export var ship: ShipController ## The Ship Scene

@export_category("Event Layer")
@export var ui_layer: CanvasLayer ## The Event UI Layer.

# remaining regular variables
# @onready variables



func _ready() -> void:
	_call_event()


func _call_event() -> void:
	var event_ui = EVENT_UI.instantiate()
	ui_layer.add_child(event_ui)


func show_beacon_map() -> void:
	var beacon_map_ui = BEACON_MAP.instantiate()
	ui_layer.add_child(beacon_map_ui)
