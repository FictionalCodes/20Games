extends Node


func _ready() -> void:
	FictionalOptionsManager.bind_notifcation("Audio", UpdateAudioLevels)
	
	
var master_bus = AudioServer.get_bus_index("Master")
var music_bus = AudioServer.get_bus_index("Music")
var sfx_bus = AudioServer.get_bus_index("Effects")



func set_bus_volume(index : int, value : float, mute: bool):
	var calcedLogValue = linear_to_db(value)

	AudioServer.set_bus_volume_db(index, calcedLogValue)
	if is_zero_approx(value) or mute:
		AudioServer.set_bus_mute(index, true)
	else:
		AudioServer.set_bus_mute(index, false)

func toggle_mute(index, status):
	AudioServer.set_bus_mute(index, status)

func UpdateAudioLevels(options: AudioOptions):
	set_bus_volume(master_bus, options.MasterVolume/100, options.MasterMuted)
	set_bus_volume(music_bus, options.MusicVolume/100, options.MusicMuted)
	set_bus_volume(sfx_bus, options.EffectVolume/100, options.EffectMuted)
