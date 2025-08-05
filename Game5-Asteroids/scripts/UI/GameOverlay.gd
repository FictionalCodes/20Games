class_name GameOverlay
extends Overlay

@export var LivesProgress: TextureProgressBar
@export var HealthProgress: TextureProgressBar


func _on_lives_updates(newValue: int) -> void:
	LivesProgress.value = newValue
func _on_health_updates(newValue: int) -> void:
	HealthProgress.value = newValue


func start_fade(fadeIn:bool = true, blocking:bool = false) -> void:
	animation.play(&"ui-fade-animation/fadein" if fadeIn else &"ui-fade-animation/fadeout")
	if blocking:
		await animation.animation_finished
