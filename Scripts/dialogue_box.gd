extends Control

# references to the child nodes
@onready var speaker_name_node = $"Panel/MarginContainer/HBoxContainer/VBoxContainer/Speaker Name"
@onready var speaker_dialogue_node = $"Panel/MarginContainer/HBoxContainer/VBoxContainer/Speaker Dialogue"

func show_dialogue(speaker: String, dialogue: String) -> void:
	visible = true
	speaker_name_node.text = speaker
	speaker_dialogue_node.clear()
	speaker_dialogue_node.append_bbcode(dialogue)
