class_name EventManager extends Node

## doc header

# PUBLIC VARIABLES
var events : Dictionary[String, Event]
var json_data_path : String = "res://data/event_data.json"


# load json data 
func _init() -> void:
	var data_loader = JSONDataLoader.new()
	var json_data = data_loader.load_json_data_from_path(json_data_path)
	if json_data != null:
		var event_data = json_data.get("Events")
		if event_data != null:
			for event in event_data:
				parse_event_data_from_json(event, event_data[event])


# parse the json data storing the events in the event dictionary
func parse_event_data_from_json(id, json_data : Dictionary) -> void:
	
	var event : Event = Event.new()
	
	event.event_type = json_data["EventType"]
	event.event_flavour = json_data["EventFlavour"]
	for dialogue in json_data["EventText"]:
		event.event_dialogue.append(dialogue)
	for dialogue_choice in json_data["DialogueChoices"]:
		event.event_dialogue_options.append(dialogue_choice)
	
	events.get_or_add(id, event)
