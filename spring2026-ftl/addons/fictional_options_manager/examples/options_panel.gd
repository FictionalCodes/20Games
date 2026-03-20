extends PanelContainer

var _settings : SubtitleSettings

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	_settings = OptionsManager.get_section(&"Subtitles")


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass


func _on_check_button_toggled(toggled_on: bool) -> void:
	_settings.OnBottom = toggled_on
