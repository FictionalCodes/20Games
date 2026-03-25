class_name EventUI extends Control

## doc comment

#signals
#enums
# constants
# static variables
# @export variables

# remaining regular variables
var event : Event

# @onready variables
@onready var dialogue_box: VBoxContainer = $PanelContainer/MarginContainer/PanelContainer/MarginContainer/DialogueBox

func _ready() -> void:
	var event_manager = EventManager.new()
	event = event_manager.events['2']
	_set_text()


func _set_text() -> void:
	# Add event dialogue
	for dialogue in event.event_dialogue:
		var label = RichTextLabel.new()
		label.text = dialogue
		label.fit_content = true
		label.bbcode_enabled = true
		dialogue_box.add_child(label)
	# Add event rewards
	if event.event_rewards:
		var hbox = HBoxContainer.new()
		dialogue_box.add_child(hbox)
		for reward in event.event_rewards:
			# Add the resource texture
			var texture_rect = TextureRect.new()
			texture_rect.texture = "res://assets/sprites/circle_sprite.png" #TODO: update to match on some enum of resource types
			hbox.add_child(texture_rect)
			# Add the resource value
			var label = Label.new()
			label.text = 1 #TODO map to some value in the event data
			hbox.add_child(label)
		
	# Add event dialogue options
	for event_choice in event.event_dialogue_options:
		var button = Button.new()
		button.text = event_choice
		dialogue_box.add_child(button)
