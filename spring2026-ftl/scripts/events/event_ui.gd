class_name EventUI extends Control

var event : Event


func _ready() -> void:
	var event_manager = EventManager.new()
	event = event_manager.events['1']
	_set_text()


func _set_text() -> void:
	%DialogueLabel.text = event.event_text
	%DialogueChoiceButton.text = event.event_choices
