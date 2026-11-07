class_name OptionsSection 
extends RefCounted

signal _options_changed
#var _notification: Signal = Signal(self, &"OptionsChanged")

## Key Name for the Section.
## 
## The unique name to be used for this configuration section.
## Will be used to load the values from the [class ConfigFile], being used as the [param section] in the [method ConfigFile.get_value] and [method ConfigFile.set_value] methods
var _section: StringName
var section_name: StringName:
	get: return _section

## Stops the On Change signal being emitted when the [method OptionsSection.notify_change] is called
## Useful when doing multiple changes you dont want to reflect yet, such as graphical options
var suppress_notifications: bool = false:
	get: return suppress_notifications
	set(value): suppress_notifications = value


var _config_key_map : Dictionary[String, StringName] = {}
var _revert_copy: Dictionary


func _init(name: StringName):
	_section = name



func addValue(name: String, propName:StringName) -> void:
	_config_key_map.set(name, propName)
	

func save(config:ConfigFile) -> void:
	for item in _config_key_map:
		config.set_value(_section, item, get(_config_key_map[item]))
	
func loadconfig(config:ConfigFile) ->void:
	suppress_notifications = true
	for item in _config_key_map:
		set(_config_key_map.get(item),config.get_value(_section, item, get(_config_key_map[item])))
	suppress_notifications = false
	notify_change()

func apply(config: ConfigFile) -> void:
	save(config)
	notify_change()

func start_edit() -> void:
	_revert_copy = _config_key_map.duplicate()

func revert_edit() -> void:
	_config_key_map = _revert_copy.duplicate()
	notify_change()
	
func notify_change() -> void:
	if !suppress_notifications:
		_options_changed.emit(self)

func bind_notification(callback: Callable) ->void:
	_options_changed.connect(callback, ConnectFlags.CONNECT_DEFERRED)
