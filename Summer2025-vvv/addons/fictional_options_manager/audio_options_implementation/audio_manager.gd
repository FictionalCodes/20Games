class_name AudioManagerExample
extends Node
## Global class to provider a wrapper aroud the AudioServer
## Binds to the OptionsManager section "Audio"

func _ready() -> void:
	OptionsManager.bind_notifcation(&"Audio", update_audio_levels)
	

# gets each bus on startup from the default audio bus configuration
# can be changed to @onready if stops working/timing
var master_bus = AudioServer.get_bus_index(&"Master")
var music_bus = AudioServer.get_bus_index(&"Music")
var sfx_bus = AudioServer.get_bus_index(&"Effects")

# the max of the scale in the settings
# we need value 0.0 - 1.0 for the log function
var AUDIO_SCALE_MAX := 100.0

## Updates Audio Levels based on values from the AudioOptions [br]
## Sets Master, Music and SFX levels
func update_audio_levels(options: AudioOptions) -> void:

	# this function is called automatically whenever the AudioOptions is updated

	set_bus_volume(master_bus, options.MasterVolume/AUDIO_SCALE_MAX, options.MasterMuted)
	set_bus_volume(music_bus, options.MusicVolume/AUDIO_SCALE_MAX, options.MusicMuted)
	set_bus_volume(sfx_bus, options.EffectVolume/AUDIO_SCALE_MAX, options.EffectMuted)

## Sets the bus volume [br]
## mutes the channel if [mute] is [code]true[/code] OR [value] is [method @GlobalScope.is_zero_approx] 
func set_bus_volume(index : int, value : float, mute: bool):
	var calcedLogValue = linear_to_db(value)

	AudioServer.set_bus_volume_db(index, calcedLogValue)
	AudioServer.set_bus_mute(index, (is_zero_approx(value) or mute))
