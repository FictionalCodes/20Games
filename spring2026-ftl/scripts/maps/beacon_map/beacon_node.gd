class_name BeaconNode extends Node2D

## The beacon node is a component of the beacon map. 

# @export variables
@export var node_texture: TextureRect
@export var tooltip: PanelContainer
@export var area: Area2D

# regular variables
var neighbours : Array[Area2D]


func _ready() -> void:
	_connect_signals()
	_set_label_text()
	tooltip.hide()
	area.hide()


func _connect_signals() -> void:
	node_texture.mouse_entered.connect(_on_mouse_entered)
	node_texture.mouse_exited.connect(_on_mouse_exited)
	

## Connect all neighbouring nodes
func connect_neighbours() -> void:
	neighbours = area.get_overlapping_areas()
	


func _set_label_text() -> void:
	%DescriptionLabel.text = 'An unexplored location'


func _on_mouse_entered() -> void:
	tooltip.show()
	print(neighbours)


func _on_mouse_exited() -> void:
	tooltip.hide()
