class_name Overlay
extends CanvasLayer

@export var ScoreLabel: Label
@onready var animation: AnimationPlayer = $AnimationPlayer
@onready var container: Container = $Container

var score:int = 0

func _on_score_updated(newScore: int) -> void:
	score = newScore
	ScoreLabel.text = String.num_int64(newScore).pad_zeros(6)

func start_fade(fadeIn:bool = true, blocking:bool = false) -> void:
	animation.play(&"fadein" if fadeIn else &"fadeout")
	if blocking:
		await animation.animation_finished

func set_visible_immediate(newVisible:bool =true) -> void:
	container.visible = newVisible
	container.modulate = Color.WHITE if newVisible else Color.TRANSPARENT
