class_name GameManager extends Node2D


@export var player_lives := 3

var _score := 0

@export var _levelManager : LevelManager
@export var _stageManger : StageManager
@export var _uiManager : UIManager

func _ready():
	_uiManager.UpdateScore(_score)
	_uiManager.UpdateLives(player_lives)
	
func BlockDestroyed(value: int = 1) -> void:
	_score += value
	_uiManager.UpdateScore(_score)

func PlayerDied() -> void :
	player_lives -= 1
	_uiManager.UpdateLives(player_lives)
