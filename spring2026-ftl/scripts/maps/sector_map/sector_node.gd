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
@onready var node_texture: TextureRect = %NodeTexture
@onready var tooltip: PanelContainer = %Tooltip


func _ready() -> void:
	_connect_signals()
	node_texture.modulate = _get_sector_type_colour()
	_set_label_text()
	tooltip.hide()


func _connect_signals() -> void:
	node_texture.mouse_entered.connect(_on_mouse_entered)
	node_texture.mouse_exited.connect(_on_mouse_exited)


func _get_sector_type_colour() -> Color:
	var colour : Color
	match sector_type:
		'Civilian': colour = Color.GREEN
		'Hostile': colour = Color.RED
		'Nebula': colour = Color.PURPLE
	return colour


func _set_label_text() -> void:
	%SectorNameLabel.text = 'Unexplored Sector'
	%SectorTypeLabel.text = sector_type
	%SectorTypeLabel.modulate = _get_sector_type_colour()
	%DescriptionLabel.text = 'A region of unexplored space'


func _on_mouse_entered() -> void:
	tooltip.show()


func _on_mouse_exited() -> void:
	tooltip.hide()
