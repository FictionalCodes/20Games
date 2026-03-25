class_name EventUI extends Control

var event : Event

@onready var dialogue_box: VBoxContainer = $PanelContainer/MarginContainer/PanelContainer/MarginContainer/DialogueBox

func _ready() -> void:
	var event_manager = EventManager.new()
	event = event_manager.events['1']
	_set_text()


func _set_text() -> void:
	for dialogue in event.event_dialogue:
		var label = RichTextLabel.new()
		label.text = dialogue
		label.fit_content = true
		label.bbcode_enabled = true
		#label.autowrap_mode = TextServer.AUTOWRAP_WORD_SMART
		
		dialogue_box.add_child(label)
	for event_choice in event.event_dialogue_options:
		var button = Button.new()
		button.text = event_choice
		dialogue_box.add_child(button)
