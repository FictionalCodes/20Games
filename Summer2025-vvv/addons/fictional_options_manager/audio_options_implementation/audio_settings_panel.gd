class_name AudioSettingsPanel
extends Control

var _options : AudioOptions = null

@export var _masterSlider : Slider
@export var _musicSlider : Slider
@export var _effectsSlider : Slider

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	OptionsManager.bind_notifcation(&"Audio", set_slider_values)

func set_slider_values(options:AudioOptions) -> void:
	# set the options if we dont have it already
	if _options == null: _options = options

	# you may wish to add a "not visible" check here to prevent this
	# update the sliders without sending the value changed signal (we get caught in infinite loop here)
	_masterSlider.set_value_no_signal(_options.MasterVolume)
	_effectsSlider.set_value_no_signal(_options.EffectVolume)
	_musicSlider.set_value_no_signal(_options.MusicVolume)
	


func _on_master_volume_slider_value_changed(value: float) -> void:
	_options.MasterVolume = value

func _on_music_volume_slider_value_changed(value: float) -> void:
	_options.MusicVolume = value

func _on_effects_volume_slider_value_changed(value: float) -> void:
	_options.EffectVolume = value

func _on_tree_exiting() -> void:
	save()
	
func save() -> void:
	OptionsManager.save_configuration()
