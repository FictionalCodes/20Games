class_name ExampleOptionsSection extends OptionsSection

var _myExample : int = 6
var MyExample: int:
	get: 
		return _myExample
	set(value):
		_myExample= value
		
var _notify_example : String = "Low"
var NotifyExample: String:
	get: 
		return _notify_example
	set(value):
		_notify_example= value
		notify_change()

func _init(section: StringName) -> void:
	super._init(section)
	
	_config_key_map["myExample"] = &"MyExample"
