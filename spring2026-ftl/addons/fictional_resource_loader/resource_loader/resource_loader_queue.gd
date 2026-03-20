class_name ResourceLoaderQueue 
extends Node

var currently_loading:Array[LoadData]
var queue: Array[LoadData]

var max_loading : int = 4

var poll_interval : float = 0.1

func _init() -> void:
	pass


## Load a Resource
## [param type_hint] is the TYPE NAME of the thing you want to load
func start_load_resource_from_path(path: String, type_hint:String = "", complete: Callable = Callable()) -> Error:
	return start_load_resource(LoadData.new(path, type_hint, complete))

func start_load_resource(load: LoadData) -> Error:
	if !ResourceLoader.exists(load.load_path):
		return Error.ERR_DOES_NOT_EXIST

	process_mode = Node.PROCESS_MODE_PAUSABLE
	# add to the currently loading set if we havent hit max, otherwise add to the queue
	if currently_loading.size() >= max_loading:
		queue.push_back(load)
		return OK

	var error := load.start_load()
	
	if error != Error.OK:
		return error 
	
	currently_loading.push_back(load)
		
	return Error.OK

var poll_current : float = 0.0
func _process(delta: float) -> void:
	# add the current time, then if its less than the interval, leave method early
	poll_current += delta
	if poll_current < poll_interval:
		return
	poll_current = 0.0
	# check load status of each one
	for i in range(currently_loading.size() -1, -1,-1):
		var curr = currently_loading[i]
		curr.poll_load()

		if curr.completed:
			currently_loading.remove_at(i)	
	
	# now stack the currently loading array with the next resource
	while currently_loading.size() < max_loading and !queue.is_empty():
		var new_load = queue.pop_front()
		new_load.start_load()
		currently_loading.push_back(new_load)
	
	if currently_loading.is_empty() and queue.is_empty():
		process_mode = Node.PROCESS_MODE_DISABLED
