class_name BeaconMap extends Control

## The beacon map allows the player to jump to a new beacon within the current sector to progress the game. 

# Signals
signal show_sector_map
signal load_event(event_id : int)

# constants
const BEACON_NODE = preload("uid://byegbnsb2s0c4")

# @export variables
@export var sector_number_label : Label
@export var next_sector_button : Button
@export var map_background : ColorRect

# remaining regular variables
var node_coordinates : Array
var beacons : Array
var start_beacon : Vector2
var exit_beacon : Vector2
var sector : int


func _ready() -> void:
	_connect_signals()
	_set_sector_number_label()
	_generate_node_coordinates()
	_set_start_beacon()
	_set_exit_beacon()
	_draw_nodes()
	#_connect_nodes() # TODO need to fix timings
	


## Connect signals
func _connect_signals() -> void:
	next_sector_button.pressed.connect(_on_next_sector_button_pressed)


## Generate node coordinates and put them into an array
func _generate_node_coordinates() -> void:
	var map_size : Vector2 = map_background.custom_minimum_size - Vector2(64,64)
	var number_of_nodes = randi_range(15, 20)
	for number in number_of_nodes:
		var x_coordinate = _halton_sequence(number + 1, 2) * map_size.x
		var y_coordinate = _halton_sequence(number + 1, 7) * map_size.y
		var coordinate = Vector2(x_coordinate, y_coordinate) + Vector2(32,32)
		node_coordinates.append(coordinate)


## Set the start beacon to the left-most beacon
func _set_start_beacon() -> void:
	for coordinate in node_coordinates:
		if not start_beacon:
			start_beacon = coordinate
		elif coordinate.x < start_beacon.x:
			start_beacon = coordinate


## Set the exit beacon to the right-most beacon
func _set_exit_beacon() -> void:
	for coordinate in node_coordinates:
		if not exit_beacon:
			exit_beacon = coordinate
		elif coordinate.x > exit_beacon.x:
			exit_beacon = coordinate


## halton sequence is a quasi-random pattern for distrubiting relatively equally points on a 2d plane. 
func _halton_sequence(index : int, base : int) -> float:
	var result : float
	var f : float = 1.0
	while (index > 0):
		f = f / float(base);
		result += f * float(index % base);
		index = index / base;
	return result;


## Draw the nodes on the map
func _draw_nodes() -> void:
	for node in node_coordinates:
		var beacon = _spawn_node(node)
		beacons.append(beacon)


## Spawns a new node at the provided vector
func _spawn_node(spawn_position : Vector2) -> Node2D:
	var node = BEACON_NODE.instantiate()
	node.position = spawn_position
	node.load_event.connect(_on_load_event)
	if spawn_position == start_beacon:
		node.set_beacon_as_current()
	if spawn_position == exit_beacon:
		node.set_beacon_as_exit()
		node.show_next_sector_button.connect(on_show_next_sector_button)
	else:
		node.hide_next_sector_button.connect(on_hide_next_sector_button)
	map_background.add_child(node)
	return node


### Connect the nodes to neighbouring nodes
#func _connect_nodes() -> void:
	#for beacon in beacons:
		#beacon.connect_neighbours()


## Hides the beacon map returning to the current ship scene
func hide_beacon_map() -> void:
	hide()


## Show the next sector button
func on_show_next_sector_button() -> void:
	next_sector_button.show()


## Hide the next sector button
func on_hide_next_sector_button() -> void:
	next_sector_button.hide()


## Show the sector map
func _on_next_sector_button_pressed() -> void:
	show_sector_map.emit()


func _on_load_event(event_id : int) -> void:
	load_event.emit(event_id)


func _set_sector_number_label() -> void:
	sector_number_label.text = str(sector)
