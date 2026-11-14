class_name TerrainChunk extends Node2D

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
	
func do_carve(carve: PackedVector2Array) -> void:
		
		var newPolys = Geometry2D.clip_polygons(_poly.polygon, carve)
		if newPolys.is_empty():
			queue_free()
		else: 
			_set_poly(newPolys[0])
			for i in range(1, newPolys.size()):
				var newTerrainBlock := terrainScene.instantiate() as TerrainChunk
				newTerrainBlock.polyPoints = newPolys[i]
				newTerrainBlock.modulate = Color(randf(), randf(), randf())

				get_parent().add_child(newTerrainBlock)
