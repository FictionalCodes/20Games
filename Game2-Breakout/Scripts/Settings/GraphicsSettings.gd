class_name GraphicsSettings extends RefCounted

var _updateSettingsCallback: Callable

const CONFIG_SECTION_NAME:= "GraphicsSettings"
func _init(callback: Callable):
	_updateSettingsCallback = callback

var _dynamicShadowsGlobal: bool = true
var DynamicShadowsGlobal: float:
	get:
		return _dynamicShadowsGlobal;
	set(value):
		_dynamicShadowsGlobal = value;
		SendValuesUpdatedEvent()

var _particlesGlobal: bool = true
var ParticlesEnabledGlobal: float:
	get:
		return _particlesGlobal;
	set(value):
		_particlesGlobal = value;
		SendValuesUpdatedEvent()

func LoadFromConfig(config: ConfigFile) -> void:
	_dynamicShadowsGlobal = config.get_value(CONFIG_SECTION_NAME, "DynamicShadowsGlobal", true)
	_particlesGlobal = config.get_value(CONFIG_SECTION_NAME, "ParticlesGlobal", true)
	SendValuesUpdatedEvent();

func SaveToConfig(config: ConfigFile) -> void:
	config.set_value(CONFIG_SECTION_NAME, "DynamicShadowsGlobal", _dynamicShadowsGlobal)
	config.set_value(CONFIG_SECTION_NAME, "ParticlesGlobal", _particlesGlobal)
	
func SendValuesUpdatedEvent() -> void:
		_updateSettingsCallback.call(self)
