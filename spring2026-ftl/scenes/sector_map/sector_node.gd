class_name SectorNode
extends Node2D

## doc comment

#signals
#enums

# constants
# static variables
# @export variables

# remaining regular variables
var sector_type : String

# @onready variables
@onready var texture: TextureRect = %Texture


func _ready() -> void:
	#mouse_entered.connect(_on_mouse_entered)
	#mouse_exited.connect(_on_mouse_exited)
	_set_node_colour(sector_type)


func _set_node_colour(sector_type : String) -> void:
	var colour : Color
	match sector_type:
		'Civilian': colour = Color.GREEN
		'Hostile': colour = Color.RED
		'Nebula': colour = Color.PURPLE
	texture.modulate = colour


func _on_mouse_entered() -> void:
	print("node entered")


func _on_mouse_exited() -> void:
	print("node exited")
	
