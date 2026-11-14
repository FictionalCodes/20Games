class_name TerrainMandager extends Node2D

@onready var polyShape = $Unchunked.polygon
@export var radius : int = 20

var chunkScene : PackedScene = preload("res://terrain.tscn")

func _ready() -> void:
	$Unchunked.offset
	var polys = Geometry2D.decompose_polygon_in_convex(polyShape)
	for poly in polys:
		var triangles = Geometry2D.triangulate_polygon(poly)
		for i in range(0, triangles.size(), 3):
			var pointBuffer := PackedVector2Array([poly[triangles[i]],poly[triangles[i+1]],poly[triangles[i+2]]])
			var tri = chunkScene.instantiate() as TerrainChunk
			tri.polyPoints = pointBuffer
			tri.modulate = Color(randf(), randf(), randf())
			add_child(tri)

		
		
		
func _unhandled_input(event: InputEvent) -> void:
	var mouseEv := event as InputEventMouseButton
	if mouseEv != null and event.button_index == MOUSE_BUTTON_LEFT:
		var carve := _make_mouse_circle(to_local(mouseEv.global_position))
		for tri in get_children():
			if tri is TerrainChunk:
				tri.do_carve(carve)
		
func _make_mouse_circle(mouse_pos: Vector2) -> PackedVector2Array:
	var nb_points = 15
	var pol : PackedVector2Array
	for i in range(nb_points):
		var angle = lerp(-PI, PI, float(i)/nb_points)
		pol.push_back(mouse_pos + Vector2(cos(angle), sin(angle)) * radius)
	return pol

	
