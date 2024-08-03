extends Node
const BUS_NAME_MUSIC := "Music"
const BUS_NAME_EFFECT := "Effects"
const BUS_NAME_ALERTS := "Alerts"

const VOLUME_SETTING_MAX := 100.0

@onready var musicBusIndex : int = AudioServer.get_bus_index(BUS_NAME_MUSIC);
@onready var effectsBusIndex : int = AudioServer.get_bus_index(BUS_NAME_EFFECT);
@onready var alertsBusIndex : int= AudioServer.get_bus_index(BUS_NAME_ALERTS);



var MusicVolume:float :
	set(value):
		UpdateAudioBusVolume(musicBusIndex, value)

var EffectVolume:float :
	set(value):
		UpdateAudioBusVolume(effectsBusIndex, value)

var AlertVolume:float :
	set(value):
		UpdateAudioBusVolume(alertsBusIndex, value)


func UpdateAudioBusVolume(busIndex:int, amount:float ):
	if is_zero_approx(amount):
		AudioServer.set_bus_mute(busIndex, true)
	else:
		var calcedVolume := log(amount/VOLUME_SETTING_MAX) *20
		AudioServer.set_bus_mute(busIndex, false)
		AudioServer.set_bus_volume_db(busIndex, calcedVolume)





