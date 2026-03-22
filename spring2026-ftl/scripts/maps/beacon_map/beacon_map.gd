class_name BeaconMap extends Control

## doc comment

#signals
#enums

# constants
const BEACON_NODE = preload("uid://byegbnsb2s0c4")

# static variables
# @export variables

# remaining regular variables
var node_coordinates : Array

# @onready variables
@onready var map_background: ColorRect = %MapBackground


func _ready() -> void:
	_generate_node_coordinates()
	_draw_nodes()


# this function generations the position vectors of nodes
func _generate_node_coordinates() -> void:
	var map_size : Vector2 = %MapBackground.custom_minimum_size - Vector2(64,64)
	print(map_size)
	var number_of_nodes = randi_range(15, 20)
	for number in number_of_nodes:
		var x_coordinate = _halton_sequence(number + 1, 2) * map_size.x
		var y_coordinate = _halton_sequence(number + 1, 7) * map_size.y
		var coordinate = Vector2(x_coordinate, y_coordinate) + Vector2(32,32)
		node_coordinates.append(coordinate)


# halton sequence is a quasi-random
func _halton_sequence(index : int, base : int) -> float:
	var result : float
	var f : float = 1.0
	while (index > 0):
		f = f / float(base);
		result += f * float(index % base);
		index = index / base;
	return result;



# this function draws the nodes on the map
func _draw_nodes() -> void:
	for node in node_coordinates:
		_spawn_node(node)


# this function spawns a new node at the provided vector
func _spawn_node(spawn_position : Vector2) -> void:
	var node = BEACON_NODE.instantiate()
	node.position = spawn_position
	map_background.add_child(node)
