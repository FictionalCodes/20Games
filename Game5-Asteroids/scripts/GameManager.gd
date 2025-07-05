class_name GameManger extends Node2D

signal scoreUpdated(newScore:int)
signal livesUpdated(newLives:int)

var _score = 0
var Score:
	get: return _score
	set(value): 
		_score = value
		scoreUpdated.emit(Score)
	
var playerLives := 2

@export var respawnTimer: Timer
@export var player: PlayerShip
@export var spawner: AsteroidSpawner
@export var playerSpawnPoint: Node2D

@export var gameOverOverlay : CanvasLayer

func _ready() -> void:
	spawner.scoreCallback = update_score
	
func update_score(value: int) -> void:
	Score += value

func player_dead() -> void:
	if playerLives <= 0:
		end_game()
		return
	
	playerLives -= 1
	livesUpdated.emit(playerLives)
	respawnTimer.start()
	spawner.stop()


	
func end_game() -> void:
	spawner.stop()
	gameOverOverlay.show()

func _on_player_respawn_timer_timeout() -> void:
	player.Respawn(playerSpawnPoint.global_position)
	spawner.start()


func reset_game() -> void:
	player.JumpToPosition(playerSpawnPoint.global_position)
	player.reset()
	spawner.start()
	gameOverOverlay.hide()
