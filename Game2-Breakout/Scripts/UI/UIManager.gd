class_name UIManager extends CanvasLayer

@export var _livesLabel : Label

@export var _scoreLabel : Label

func UpdateScore(newScore : int) -> void:
	_scoreLabel.text = "%06d" % newScore

func UpdateLives(newLives : int) -> void:
	_livesLabel.text = "%02d" % newLives

