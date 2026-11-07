class_name BaseUnit extends CharacterBody2D


signal pathfinding_destination_reached
signal unit_destroyed


@export_category("Movement Params")
@export var unitMaxSpeed: float = 100.0
@export var pathfindingWaypointMargin: float = 16.0

@export_category("HP")
@export var hp := 10.0
var isDead = false

@onready var _tankBase := $Base as AnimateableBody
#@onready var _turret := $Turret as AnimateableBody

@onready var _brain:= $BrainNode as BasicUnitBrain

var _query_parameters := NavigationPathQueryParameters2D.new()
var _query_result := NavigationPathQueryResult2D.new()
var _currentPath : Array[Vector2]
var _destinationReached = true

var _next_pathfinding_refresh : float = randf() + 1.0

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	_query_parameters.map = get_world_2d().get_navigation_map()
	#_query_parameters.simplify_path = true
	#_query_parameters.simplify_epsilon = 32.0
	#_query_parameters.path_postprocessing = NavigationPathQueryParameters2D.PATH_POSTPROCESSING_NONE 

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
	velocity = moveVector * unitMaxSpeed
	
	#_turret.lookDir = target_position - global_position
	_tankBase.lookDir = moveVector
	
	

func set_move_target(new_target: Vector2) -> void:
	var nextPath := await _query_path(new_target)
	
	_currentPath = nextPath
	_destinationReached = false

func _query_path(p_target_position: Vector2, p_navigation_layers: int = 1) -> PackedVector2Array:
	if not is_inside_tree():
		return PackedVector2Array()

	_query_parameters.start_position = global_position
	_query_parameters.target_position = p_target_position
	_query_parameters.navigation_layers = p_navigation_layers

	await NavigationServer2D.query_path(_query_parameters, _query_result)
	var path: PackedVector2Array = _query_result.get_path()

	return path
