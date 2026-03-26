class_name EventLoader extends Node

## doc comment

#signals
#enums
# constants
# static variables
# @export variables

# remaining regular variables
var events : Dictionary[String, Event]
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
				_parse_event_data_from_json(event, event_data[event])


## Parses event data into an Event object and stores it in the events dictionary.
func _parse_event_data_from_json(id, json_data : Dictionary) -> void:
	
	var event : Event = Event.new()
	
	event.event_type = json_data["EventType"]
	event.event_flavour = json_data["EventFlavour"]
	for dialogue in json_data["EventText"]:
		event.event_dialogue.append(dialogue)
	for dialogue_choice in json_data["DialogueChoices"]:
		event.event_dialogue_options.append(dialogue_choice)
	var rewards = json_data.get("Rewards")
	if rewards:
		for reward in rewards:
			event.event_rewards.append(reward)
	
	events.get_or_add(id, event)
