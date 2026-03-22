class_name SectorMap extends Control

## doc comment

#signals
#enums
# constants
const SECTOR_NODE = preload("uid://ryst2kfnr5ad")
# static variables
# @export variables

# remaining regular variables
var number_of_columns : int = 8
var node_cordinates : Array
var sector_types := ['Civilian', 'Hostile', 'Nebula'] # should be moved to some global enum?

# @onready variables
@onready var map_background: ColorRect = %MapBackground


func _ready() -> void:
	_generate_node_coordinates()
	_draw_nodes()
	_draw_lines()


# this function generates semi-randomised node positions
func _generate_node_coordinates() -> void:
	var spawn_position_x := 50
	for column in number_of_columns:
		var nodes_in_column : Array[Vector2]
		var number_of_nodes : int
		if column == 0 or column == 7:
			number_of_nodes = 1
		else:
			number_of_nodes = randi_range(2,4)
		var y_positions = _get_node_y_positions(number_of_nodes)
		for y in y_positions:
			nodes_in_column.append(Vector2(spawn_position_x, y))
		node_cordinates.append(nodes_in_column)
		spawn_position_x += 75


# this function provides the y positions of nodes depending on the number of nodes at the x position
func _get_node_y_positions(number_of_nodes: int) -> Array:
	var y_positions : Array[int]
	match number_of_nodes:
		1 : y_positions = [125]
		2 : y_positions = [100, 150]
		3 : y_positions = [75, 125, 175]
		4 : y_positions = [50, 100,150,200]
	return y_positions


# this function draws the nodes on the map
func _draw_nodes() -> void:
	for column in node_cordinates:
		for node in column:
			_spawn_node(node)


# this function spawns a new node at the provided vector
func _spawn_node(spawn_position : Vector2) -> void:
	var node = SECTOR_NODE.instantiate()
	node.position = spawn_position
	node.sector_type = sector_types.pick_random()
	map_background.add_child(node)


# this function draws the lines on the map
func _draw_lines() -> void:
	var previous_column
	for column in node_cordinates:
		for node in column:
			if previous_column:
				for previous_node in previous_column:
					if len(previous_column) == 1 or len(column) == 1:
						_spawn_line(node, previous_node)
					elif len(column) == 2:
						if node.y == 100 and previous_node.y <= 125:
							_spawn_line(node, previous_node)
						elif node.y == 150 and previous_node.y >= 125:
							_spawn_line(node, previous_node)
					elif len(column) == 3:
						if node.y == previous_node.y:
							_spawn_line(node, previous_node)
						elif abs(node.y - previous_node.y) <= 50 and len(previous_column) != 3:
							_spawn_line(node, previous_node)
					elif len(column) == 4:
						if len(previous_column) == 2 and node.y < 125 and previous_node.y < 125:
							_spawn_line(node, previous_node)
						elif len(previous_column) == 2 and node.y > 125 and previous_node.y > 125:
							_spawn_line(node, previous_node)
						elif node.y == previous_node.y:
							_spawn_line(node, previous_node)
						elif len(previous_column) == 3 and node.y == 50 and previous_node.y < 125:
							_spawn_line(node, previous_node)
						elif len(previous_column) == 3 and node.y == 200 and previous_node.y > 125:
							_spawn_line(node, previous_node)
						elif len(previous_column) == 3 and abs(previous_node.y - node.y) <= 50:
							_spawn_line(node, previous_node)
		previous_column = column


func _spawn_line(node : Vector2, previous_node: Vector2) -> void:
	var line = Line2D.new()
	line.modulate = Color.WHITE
	line.add_point(node)
	line.add_point(previous_node)
	line.width = 2
	line.z_index = 1
	map_background.add_child(line)
