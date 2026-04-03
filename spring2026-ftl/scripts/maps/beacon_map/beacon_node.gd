class_name BeaconNode extends Node2D

## The beacon node is a component of the beacon map. 

# Signals
signal load_event(event_id : int)
signal show_next_sector_button
signal hide_next_sector_button

# Constants
const DOTTED_LINE = preload("uid://djyat7v1b4kg7")
const ANIMATED_LINE = preload("uid://boxbwcs7tsgt8")

# @export variables
@export var node_texture: TextureRect
@export var tooltip: PanelContainer
@export var tooltip_label: Label
@export var area: Area2D
@export var current_beacon_indicator: Polygon2D
@export var exit_beacon_indicator: Label
@export var click_zone: Area2D

# regular variables
var neighbours : Array[Area2D]
var lines : Array[Line2D]
var is_current_beacon : bool
var is_exit_beacon: bool
var is_explored: bool
var event_id : int = 1


func _ready() -> void:
	_connect_signals()
	tooltip.hide()


## Connect signals to their events
func _connect_signals() -> void:
	click_zone.mouse_entered.connect(_on_mouse_entered)
	click_zone.mouse_exited.connect(_on_mouse_exited)
	click_zone.input_event.connect(_on_click_zone_input_event)


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


## Show the beacons connections
func _show_connections() -> void:
	for line in lines:
		line.show()


## Hide the beacons connections
func _hide_connections() -> void:
	for line in lines:
		line.hide()


func _set_label_text(text: String) -> void:
	tooltip_label.text = text


func _on_mouse_entered() -> void:
	tooltip.show()
	if lines.is_empty():
		connect_neighbours()
	_show_connections()


func _on_mouse_exited() -> void:
	tooltip.hide()
	_hide_connections()


func _on_click_zone_input_event(_viewport: Node, event: InputEvent, _shape_idx: int) -> void:
	if event.is_action_pressed("confirm") and is_current_beacon == false:
		for neighbour in neighbours:
			var beacon = neighbour.get_parent()
			if beacon.is_current_beacon:
				set_beacon_as_current()
				beacon.set_beacon_as_not_current()
				if is_exit_beacon:
					show_next_sector_button.emit()
				else:
					hide_next_sector_button.emit()


## Set the beacon as the current beacon and show the current beacon indicator
func set_beacon_as_current() -> void:
	current_beacon_indicator.show()
	is_current_beacon = true
	is_explored = true
	if not is_exit_beacon:
		_set_label_text("Your current location.")
	load_event.emit(event_id)


## Set the beacon as not the current beacon and hide the current beacon indicator
func set_beacon_as_not_current() -> void:
	is_current_beacon = false
	current_beacon_indicator.hide()
	if not is_exit_beacon:
		_set_label_text("An explored location.")


## Set the beacon as the exit beacon and show the exit beacon indicator
func set_beacon_as_exit() -> void:
	is_exit_beacon = true
	exit_beacon_indicator.show()
	_set_label_text("This is the exit beacon. Go here to jump to the next sector.")
	
