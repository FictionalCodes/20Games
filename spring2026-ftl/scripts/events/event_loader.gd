extends Node

## doc comment

#signals
#enums
# constants
# static variables
# @export variables

# remaining regular variables
var events : Array
var json_data_path : String = "res://data/event_data.json"

var json_data

# @onready variables


func _init() -> void:
	_load_event_data_from_json()


## Loads the event data from JSON and loops through to create each event object.
func _load_event_data_from_json() -> void:
	var data_loader = JSONDataLoader.new()
	json_data = data_loader.load_json_data_from_path(json_data_path)
	if json_data != null:
		var event_data = json_data.get("Events")
		if event_data != null:
			for event in event_data:
				_parse_event_data_from_json(event)


## Parses event data into an Event object and stores it in the events dictionary.
func _parse_event_data_from_json(event_data) -> void:
	
	var event : Event = Event.new()
	
	event.event_type = event_data["EventType"]
	event.event_flavour = event_data["EventFlavour"]
	for dialogue in event_data["EventText"]:
		event.event_dialogue.append(dialogue)
	for dialogue_choice in event_data["DialogueChoices"]:
		event.event_dialogue_options.append(dialogue_choice)
	
	events.append(event)
