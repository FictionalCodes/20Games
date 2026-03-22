class_name ShipController extends Node


@export var total_power : int
@export var power_avalible : int
@export var total_HP : int
@export var current_HP : int

@onready var overlay = $CanvasLayer/ShipUiOverlay

func _ready() -> void:
	create_system("Test1")
	create_system("Test2")

func get_power(amount: int = 1) -> bool:
	if power_avalible >= amount:
		power_avalible -= amount
		return true
	return false

func return_power(amount: int = 1) -> void:
	power_avalible += amount if power_avalible + amount < total_power else 0

func create_system(sysname: String) -> void:
	var newSystem := ShipSystem.new(get_power, return_power)
	newSystem.system_name = sysname
	
	overlay.add_system(newSystem)
