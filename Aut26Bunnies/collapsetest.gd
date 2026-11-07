class_name Terrain extends Node2D

@export var radius : int = 20
@onready var _poly := $Polygon2D as Polygon2D
@onready var _colision := $CollisionPolygon2D
var carve_area : Polygon2D
# Called when the node enters the scene tree for the first time.

var terrainScene := preload("res://terrain.tscn")

@export var polyPoints : PackedVector2Array = []

func _ready() -> void:
		_set_poly(_poly.polygon if polyPoints.is_empty() else polyPoints)

func _set_poly(new_pol: PackedVector2Array):
		_poly.polygon = new_pol
		_colision.set_deferred("polygon", new_pol)

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass
	

func _unhandled_input(event: InputEvent) -> void:
	var mouseEv := event as InputEventMouseButton
	if mouseEv != null and event.button_index == MOUSE_BUTTON_LEFT:
		var carve := _make_mouse_circle(mouseEv.position)
		var newPolys = Geometry2D.clip_polygons(_poly.polygon, carve)
		if newPolys.is_empty():
			queue_free()
		else: 
			_set_poly(newPolys[0])
			for i in range(1, newPolys.size()):
				var newTerrainBlock := terrainScene.instantiate() as Terrain
				newTerrainBlock.polyPoints = newPolys[i]
				get_parent().add_child(newTerrainBlock)
		
func _make_mouse_circle(mouse_pos: Vector2) -> PackedVector2Array:
	var nb_points = 15
	var pol : PackedVector2Array
	for i in range(nb_points):
		var angle = lerp(-PI, PI, float(i)/nb_points)
		pol.push_back(mouse_pos + Vector2(cos(angle), sin(angle)) * radius)
	return pol
