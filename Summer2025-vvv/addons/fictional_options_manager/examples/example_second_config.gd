class_name SecondConfigExample extends OptionsManager

# example showing how to set up a second configuration loader, directly injecting a new type
func _init() -> void:
	config_to_load = "usr://some/other/path"
	add_config_section(ExampleOptionsSection.new(&"Example"))
