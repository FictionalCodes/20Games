class_name VisualSettings extends RefCounted

var colourResources :ResourceGroup = load("res://Resources/ColourSetGroup.tres")
var _colourSettings : Array[ColourSettings] = []

var _updateSettingsCallback: Callable

const CONFIG_SECTION_NAME:= "VisualSettings"

func _init(callback: Callable):
	_updateSettingsCallback = callback
	colourResources.load_all_into(_colourSettings)

var _colourSetName: String = "Default"
var _currentColourSet: ColourSettings


var ColourSetName: String:
	get:
		return _colourSetName;
	set(value):

		UpdateColourSet(value)
		SendValuesUpdatedEvent()

func UpdateColourSet(setName : String) -> void:
	var found: ColourSettings = null
	for colset in _colourSettings:
		if colset.name.nocasecmp_to(setName):
			found = colset
			break
	
	if found == null:
		found = _colourSettings.front()
	
	_colourSetName = found.name
	_currentColourSet = found

var CurrentColourSet : ColourSettings:
	get: return _currentColourSet

func SendValuesUpdatedEvent() -> void:
	_updateSettingsCallback.call_deferred(self)


func LoadFromConfig(config: ConfigFile) -> void:
	_colourSetName = config.get_value(CONFIG_SECTION_NAME, "ColourSet", "Default")
	UpdateColourSet(_colourSetName)
	SendValuesUpdatedEvent();

func SaveToConfig(config: ConfigFile) -> void:
	config.set_value(CONFIG_SECTION_NAME, "ColourSet", _colourSetName)
