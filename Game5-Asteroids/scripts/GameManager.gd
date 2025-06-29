class_name GameManger extends Node2D

signal scoreUpdated(newScore:int)

var _score = 0
var Score:
	get: return _score
	set(value): 
		_score = value
		scoreUpdated.emit(Score)
	
var _playerLives := 2

@export var player: PlayerShip
@export var spawner: AsteroidSpawner

func _ready() -> void:
	spawner.scoreCallback = update_score
	
func update_score(value: int) -> void:
	Score += value

func player_dead() -> void:
	if _playerLives <= 0:
		end_game()
		
func end_game() -> void:
	pass
