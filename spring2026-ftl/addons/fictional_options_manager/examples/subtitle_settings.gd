class_name SubtitleSettings
extends OptionsSection

var OnBottom: bool = false:
	get: return OnBottom
	set(value):
		OnBottom = value
		notify_change()


func _init() -> void:
	super._init("Subtitles")
	_config_key_map["OnBottom"] = &"OnBottom"
