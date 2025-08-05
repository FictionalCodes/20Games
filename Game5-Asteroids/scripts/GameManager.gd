class_name GameManger extends Node2D

signal scoreUpdated(newScore:int)
signal livesUpdated(newLives:int)
signal playerRespawn
signal gameReset

var _score = 0
var Score:
	get: return _score
	set(value): 
		_score = value
		scoreUpdated.emit(Score)
	
var _playerLives := 2
var PlayerLives:
	get: return _playerLives
	set(value): 
		_playerLives = value
		livesUpdated.emit(_playerLives)
@export var respawnTimer: Timer
@export var player: PlayerShip
@export var spawner: AsteroidSpawner
@export var playerSpawnPoint: Node2D

@export var gameOverOverlay : MenuOverlay
@export var gameStatsOverlay : GameOverlay

@onready var pauseHandler: PauseHandler = $PauseHandler

func _ready() -> void:
	spawner.scoreCallback = update_score
	
func update_score(value: int) -> void:
	Score += value

func player_dead() -> void:
	if PlayerLives <= 0:
		end_game()
		return
	
	PlayerLives -= 1
	respawnTimer.start()
	spawner.stop()

func set_paused(paused: bool) -> void:
	if paused:
		gameOverOverlay.show_menu(MenuOverlay.MenuType.Pause)
	else:
		gameOverOverlay.set_visible_immediate(false)
		
func end_game() -> void:
	spawner.stop()
	gameOverOverlay.start_fade()
	gameStatsOverlay.start_fade(false)
	

func _on_player_respawn_timer_timeout() -> void:
	playerRespawn.emit()

func reset_game() -> void:
	pauseHandler.set_paused(false)
	spawner.stop(true)

	Score = 0
	PlayerLives = 2
	player.reset()
	gameStatsOverlay.start_fade()
	await gameOverOverlay.start_fade(false, true)
	await player.Respawn()
	spawner.start()
	gameReset.emit()

func _on_quit_button_pressed() -> void:
	get_tree().quit()
