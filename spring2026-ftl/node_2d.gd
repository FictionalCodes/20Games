extends Node2D

func _ready() -> void:
	for i in range(100):
		ResourceLoading.start_load_resource(LoadData.new("res://test2.tscn", "", loading_done, progress))
	
func loading_done(loaded:LoadData) -> void:
	print(loaded.load_path, "Done")

func progress(loaded: LoadData) -> void:
	print(loaded.load_path, loaded.last_loaded_percent)
