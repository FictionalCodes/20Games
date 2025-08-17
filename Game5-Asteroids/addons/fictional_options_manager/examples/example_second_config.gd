class_name SecondConfigExample extends FictionalOptionsManager

func _init() -> void:
	config_to_load = "usr://some/other/path"
	add_config_section("Example", ExampleOptionsSection.new("Example"))
