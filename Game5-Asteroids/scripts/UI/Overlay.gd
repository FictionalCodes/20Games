class_name Overlay
extends CanvasLayer

@export var ScoreLabel: Label


func _on_score_updated(newScore: int) -> void:
	ScoreLabel.text = String.num_int64(newScore).pad_zeros(6)
