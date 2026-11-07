class_name FictionalOptionsManager extends Node
## Logical Wrapper for [class ConfigFile] using [class OptionsSection]

var config_to_load : String
var _config := ConfigFile.new()

var _config_sets :Dictionary[StringName, OptionsSection] = {}
func _init() -> void:
	config_to_load = ProjectSettings.get_setting(OptionsManagerConsts.config_file_path_settings_prop_path, OptionsManagerConsts.config_file_path_default)
	var type_names = ProjectSettings.get_setting(OptionsManagerConsts.config_file_sections_settings_prop_path, []) as PackedStringArray
	for type in type_names:
		var item := ClassUtils.get_type(type) as GDScript
		if item != null:
			add_config_section(item.new())
		else:
			push_error("Unable to locate ", type, " as a class within the project")
	
func _ready():
	load_configuration()

## Adds a new [class OptionsSection] with a specific overridden name
##
## will set [member OptionsSection.section_name] and then call [method FictionalOptionsManager.add_config_section] with the updated type
func add_config_section_with_name(sectionName: StringName, type: OptionsSection) -> void:
	type.section_name = sectionName
	add_config_section(type)
	
## Manually add a new [class OptionsSection] to the set to be loaded from the [class ConfigFile] [br]
##
## Will immedietly be loaded once added to the internal dictionary of sections.
## This will result in any bound callbacked for change notification being called. [br]
## If the Config does not have the [member OptionsSection.section_name] then then [param type] will [b]NOT[/b] be loaded,will remain at default values and will [b]NOT[/b] send the changed notification 
func add_config_section(type: OptionsSection) -> void:
	_config_sets[type.section_name] = type
	if _config.has_section(type.section_name):
		type.loadconfig(_config)

## Will read the configured [class ConfigFile] and load its values into any already configured [class OptionsSection]
##
## Will be called Automatically on Ready
## Will match any Sections within the [class ConfigFile] to any [class OptionsSection] already included in the internal map
## Those sections are then loaded, and subsequently send their notifications
## If the Config does not have the [member OptionsSection.section_name] then then [param type] will [b]NOT[/b] be loaded,will remain at default values and will [b]NOT[/b] send the changed notification 
func load_configuration() -> void:
	_config.load(config_to_load)

	for cset: OptionsSection in _config_sets.values():
		if _config.has_section(cset.section_name):
			cset.loadconfig(_config)

## Writes all values to the config via [method OptionsSection.save] [br]
## Will also save the file directly via [method ConfigFile.save]
func save_configuration() -> void:
	for cset: OptionsSection in _config_sets.values():
		cset.apply(_config)
	
	_config.save(config_to_load)

## Get the [class OptionsSection] saved here by [param sectionName]
##
## Will be NULL if does not exist yet
func get_section(sectionName: StringName) -> OptionsSection:
	return _config_sets.get(sectionName)
	
## Binds a callback to the provided [class OptionsSection]
##
## will try to find the [class OptionsSection] for the [param sectionName].
## If found, will bind the [class Callable] and immedietly [method Callable.call] [param callback][br]
## returns true/false as utility for if found
func bind_notifcation(sectionName: StringName, callback: Callable) -> bool:
	var found :OptionsSection = _config_sets.get(sectionName)
	if found == null: return false
	
	found.bind_notification(callback)
	callback.call(found)
	return true
