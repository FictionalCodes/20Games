class_name BeaconNode extends Node2D

## The beacon node is a component of the beacon map. 

# Constants
const DOTTED_LINE = preload("uid://djyat7v1b4kg7")
const ANIMATED_LINE = preload("uid://boxbwcs7tsgt8")

# @export variables
@export var node_texture: TextureRect
@export var tooltip: PanelContainer
@export var area: Area2D
@export var current_beacon_indicator: Polygon2D
@export var exit_beacon_indicator: Label
@export var click_zone: Area2D

# regular variables
var neighbours : Array[Area2D]
var lines : Array[Line2D]
var is_current_beacon : bool
var is_exit_beacon: bool

func _ready() -> void:
	_connect_signals()
	_set_label_text()
	tooltip.hide()


func _connect_signals() -> void:
	click_zone.mouse_entered.connect(_on_mouse_entered)
	click_zone.mouse_exited.connect(_on_mouse_exited)


## Connect all neighbouring nodes
func connect_neighbours() -> void:
	neighbours = area.get_overlapping_areas()
	for neighbour in neighbours:
		var line = Line2D.new()
		add_child(line)
		lines.append(line)
		# Line Positioning
		line.position = Vector2.ZERO
		line.add_point(Vector2.ZERO)
		line.add_point(neighbour.global_position - global_position)
		# Line Visuals
		line.width = 5.0
		#line.modulate = Color.YELLOW # TODO not working with animated line shader
		line.texture = DOTTED_LINE
		line.texture_mode = Line2D.LINE_TEXTURE_TILE
		line.texture_repeat = CanvasItem.TEXTURE_REPEAT_ENABLED
		line.material = ANIMATED_LINE

		


func _show_connections() -> void:
	for line in lines:
		line.show()


func _hide_connections() -> void:
	for line in lines:
		line.hide()


func _set_label_text() -> void:
	%DescriptionLabel.text = 'An unexplored location'


func _on_mouse_entered() -> void:
	tooltip.show()
	if lines.is_empty():
		connect_neighbours()
	_show_connections()


func _on_mouse_exited() -> void:
	tooltip.hide()
	_hide_connections()


func set_beacon_as_current() -> void:
	is_current_beacon == true
	current_beacon_indicator.show()


func set_beacon_as_exit() -> void:
	is_exit_beacon == true
	exit_beacon_indicator.show()
	
