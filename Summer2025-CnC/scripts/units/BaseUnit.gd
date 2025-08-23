class_name BaseUnit extends Node2D


signal pathfinding_destination_reached

var _query_parameters := NavigationPathQueryParameters2D.new()
var _query_result := NavigationPathQueryResult2D.new()
var _currentPath : Array[Vector2]
var _destinationReached = true

@export var unitSpeed: float = 100.0
@export var pathfindingWaypointMargin: float = 16.0

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	_query_parameters.map = get_world_2d().get_navigation_map()
	#_query_parameters.simplify_path = true
	#_query_parameters.simplify_epsilon = 32.0
	#_query_parameters.path_postprocessing = NavigationPathQueryParameters2D.PATH_POSTPROCESSING_NONE 



# Called every frame. 'delta' is the elapsed time since the previous frame.
func _physics_process(delta: float) -> void:
	move_on_path(delta)
	
func move_on_path(delta: float) -> void:
	if _currentPath.is_empty():
		return
		
	var currentWaypoint : Vector2 = _currentPath.front()
	if global_position.distance_to(currentWaypoint) < pathfindingWaypointMargin:
		_currentPath.pop_front()
		if _currentPath.is_empty():
			_destinationReached = true
			pathfinding_destination_reached.emit()
			return
		else:
			currentWaypoint = _currentPath.front()
	
	var moveVector = global_position.direction_to(currentWaypoint)
	global_position += moveVector * unitSpeed * delta
	
	

func set_move_target(target_position: Vector2, append: bool = false) -> void:
	var nextPath := _query_path(target_position)
	if not append:
		_currentPath.clear()
		
	_currentPath.append_array(nextPath)
		
	_destinationReached = false

func _query_path(p_target_position: Vector2, p_navigation_layers: int = 1) -> PackedVector2Array:
	if not is_inside_tree():
		return PackedVector2Array()

	_query_parameters.start_position = global_position
	_query_parameters.target_position = p_target_position
	_query_parameters.navigation_layers = p_navigation_layers
	

	NavigationServer2D.query_path(_query_parameters, _query_result)
	var path: PackedVector2Array = _query_result.get_path()

	return path
