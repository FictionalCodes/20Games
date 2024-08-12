class_name LevelManager extends Node2D


var _currentLayerNumber := 0

var _levelsInSetNotUsed : Array[int]

var levelSet: TileMap


@onready var blocks_container : StageManager = $"../StageBlocks" as StageManager

# Called when the node enters the scene tree for the first time.
func _ready():
	setup_level_set($Blocks)
	randomise_and_setup_next_level.call_deferred()


func setup_level_set(blocksMap : TileMap) -> void:
	levelSet = blocksMap
	# first up disable every single layer
	# this should already be done but just in case
	# this is a datamap, not actually a thing to display
	for layerIndex in blocksMap.get_layers_count():
		_levelsInSetNotUsed.append(layerIndex)
		blocksMap.set_layer_enabled(layerIndex, false)

func randomise_and_setup_next_level() -> void:
	var item := randi_range(0, _levelsInSetNotUsed.size() - 1)
	var selectedStageNumber = _levelsInSetNotUsed.pop_at(item)
	_currentLayerNumber = selectedStageNumber
	await blocks_container.setup_next_level(levelSet, selectedStageNumber)

func stage_compelted() -> void:
	randomise_and_setup_next_level()
