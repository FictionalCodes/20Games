class_name StageManager extends Node2D

var blockPrefab := preload("res://prefabs/BasicBlock.tscn")
var _colourSettings : ColourSettings 

func _ready():
	_colourSettings = SettingsManager.VisualConfig.CurrentColourSet

func setup_next_level(levelSet: TileMap, layer : int) -> void :
	var layerCoords := levelSet.get_used_cells(layer)

	for coords in layerCoords:
		var tileData := levelSet.get_cell_tile_data(layer, coords)
		var newBlock := blockPrefab.instantiate()

		newBlock.setup_from_grid(levelSet.map_to_local(coords), 
								_colourSettings.block_colours[tileData.get_custom_data("ColourKey")], 
								1, 
								blockDestroyed)
		add_child(newBlock)
		await get_tree().process_frame

func blockDestroyed():
	pass
