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
@onready var tooltip: PanelContainer = %Tooltip


func _ready() -> void:
	texture.mouse_entered.connect(_on_mouse_entered)
	texture.mouse_exited.connect(_on_mouse_exited)
	texture.modulate = _get_sector_type_colour()
	_set_label_text()
	tooltip.hide()


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
	
