extends Node

const CONFIG_FILE_PATH: String = "user://config.cfg";

@onready var _config := ConfigFile.new()

@onready var _audioSettings := AudioSettings.new(SendAudioSettingsUpdated)
@onready var _graphicsSettings := GraphicsSettings.new(SendGraphicsSettingsUpdated)
@onready var _visualSettings := VisualSettings.new(SendVisualSettingsUpdated)


var AudioConfig : AudioSettings:
	get: return _audioSettings
var GraphicsConfig : GraphicsSettings:
	get: return _graphicsSettings
var VisualConfig : VisualSettings:
	get: return _visualSettings 


signal AudioSettingsUpdated(audioSettings: AudioSettings)
signal GraphicsSettingsUpdated(graphicsSettings: AudioSettings)
signal VisualSettingsUpdated(colourSettings: VisualSettings)

func _ready():
	_config.load(CONFIG_FILE_PATH)
	LoadConfiguration(_config)


func LoadConfiguration(config: ConfigFile) -> void:
	_audioSettings.LoadFromConfig(config)
	_graphicsSettings.LoadFromConfig(config)
	_visualSettings.LoadFromConfig(config)

func SaveConfiguration(config: ConfigFile) -> void:
	_audioSettings.SaveToConfig(config)
	_graphicsSettings.SaveToConfig(config)
	_visualSettings.SaveToConfig(config)


func SendAudioSettingsUpdated(audioSettings: AudioSettings):
	AudioSettingsUpdated.emit(audioSettings)

func SendGraphicsSettingsUpdated(graphicsSettings: GraphicsSettings):
	GraphicsSettingsUpdated.emit(graphicsSettings)

func SendVisualSettingsUpdated(graphicsSettings: VisualSettings):
	VisualSettingsUpdated.emit(graphicsSettings)

