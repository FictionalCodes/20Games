class_name StageManager extends Node2D

var blockPrefab := preload("res://prefabs/BasicBlock.tscn")
var _colourSettings : ColourSettings 
var _currentBlockCount := 0

signal StageCompelted()
signal ScoreUpdate(scoreValue: int)

func _ready():
	_colourSettings = SettingsManager.VisualConfig.CurrentColourSet

func setup_next_level(levelSet: TileMap, layer : int) -> void :
	var layerCoords := levelSet.get_used_cells(layer)

	for coords in layerCoords:
		var tileData := levelSet.get_cell_tile_data(layer, coords)
		var newBlock := blockPrefab.instantiate()

		newBlock.setup_from_grid(levelSet.map_to_local(coords), 
								1, 
								tileData.get_custom_data("ColourKey"), 
								blockDestroyed)
		newBlock.UpdateColourFromArray(_colourSettings.block_colours)
		add_child(newBlock)
		_currentBlockCount += 1
		await get_tree().process_frame

func blockDestroyed(scoreValue: int):
	_currentBlockCount -= 1
	if _currentBlockCount <= 0:
		StageCompelted.emit()

	ScoreUpdate.emit(scoreValue)
