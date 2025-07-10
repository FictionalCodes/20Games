class_name Overlay
extends CanvasLayer

@export var ScoreLabel: Label
@export var LivesProgress: TextureProgressBar
@export var HealthProgress: TextureProgressBar


func _on_score_updated(newScore: int) -> void:
	ScoreLabel.text = String.num_int64(newScore).pad_zeros(6)

func _on_lives_updates(newValue: int) -> void:
	LivesProgress.value = newValue
func _on_health_updates(newValue: int) -> void:
	HealthProgress.value = newValue
