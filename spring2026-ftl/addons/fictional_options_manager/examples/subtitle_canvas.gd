extends CanvasLayer

@onready var subs: ColorRect = $SubtitlesBackground

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	OptionsManager.bind_notifcation(&"Subtitles", _update_subtitle_position)


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass

func _update_subtitle_position(options:SubtitleSettings) -> void:
	var preset = Control.PRESET_CENTER_BOTTOM if options.OnBottom else Control.PRESET_CENTER_TOP
	
	subs.set_anchors_and_offsets_preset(preset, Control.PRESET_MODE_KEEP_SIZE, 10)
