class_name AudioOptions extends OptionsSection

var MasterVolume: float = 25.0:
	get: return MasterVolume
	set(value):
		MasterVolume = value
		notify_change()
var MusicVolume: float = 25.0:
	get: return MusicVolume
	set(value):
		MusicVolume = value
		notify_change()
var EffectVolume: float = 25.0:
	get: return EffectVolume
	set(value):
		EffectVolume = value
		notify_change()

var MasterMuted: bool = false:
	get: return MasterMuted
	set(value):
		MasterMuted = value
		notify_change()
		
var MusicMuted: bool = false:
	get: return MusicMuted
	set(value):
		MusicMuted = value
		notify_change()
var EffectMuted: bool = false:
	get: return EffectMuted
	set(value):
		EffectMuted = value
		notify_change()

func _init() -> void:
	super._init("Audio")
	_config_key_map["MasterVolume"] = &"MasterVolume"
	_config_key_map["MusicVolume"] = &"MusicVolume"
	_config_key_map["EffectVolume"] = &"EffectVolume"
	_config_key_map["MasterMuted"] = &"MasterMuted"
	_config_key_map["MusicMuted"] = &"MusicMuted"
	_config_key_map["EffectMuted"] = &"EffectMuted"
