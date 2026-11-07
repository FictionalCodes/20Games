class_name LoadData extends RefCounted

var _load_path: String
var _load_finished_callback: Callable
var _progress_update: Callable
var completed: bool = false
var type_hint: String
var loaded_resource: Resource
var error : int = Error.ERR_LOCKED

var last_loaded_percent = 0

func _init(path: String, hint: String = "", complete: Callable = Callable(), progress: Callable = Callable()) -> void:
	_load_path = path
	_load_finished_callback = complete
	type_hint = hint
	_progress_update = progress
	
func poll_load() -> Error:
	var progress = []
	var state = ResourceLoader.load_threaded_get_status(_load_path, progress)
	last_loaded_percent = progress[0]
	_progress_update.call_deferred(self)

	match state:
		ResourceLoader.THREAD_LOAD_LOADED:
			# as long as we have a callback, do it				
			loaded_resource = ResourceLoader.load_threaded_get(_load_path)
			if !_load_finished_callback.is_null():
				_load_finished_callback.call_deferred(self)
				error = OK

			completed = true
			return OK
		#-----------------------------------
		[ResourceLoader.THREAD_LOAD_FAILED, ResourceLoader.THREAD_LOAD_INVALID_RESOURCE]:
			error = state
			completed = true
			_load_finished_callback.call_deferred(self)
			return Error.ERR_CANT_ACQUIRE_RESOURCE

		_: 
			return OK

func start_load() -> Error:
	error = ResourceLoader.load_threaded_request(_load_path, type_hint)
	if error != OK:
		_load_finished_callback.call_deferred(self)
	return error
