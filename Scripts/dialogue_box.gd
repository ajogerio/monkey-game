extends Control

# references to the child nodes
@onready var speaker_name = $"Panel/MarginContainer/HBoxContainer/VBoxContainer/Speaker Name"
@onready var speaker_dialogue = $"Panel/MarginContainer/HBoxContainer/VBoxContainer/Speaker Dialogue"

var typing_speed := 0.03
var is_typing := false

func show_dialogue(speaker: String, text: String) -> void:
	visible = true
	speaker_name.text = speaker
	
	speaker_dialogue.clear()
	speaker_dialogue.append_text(text)
	speaker_dialogue.visible_characters = 0
	
	is_typing = true
	_start_typing()

func _start_typing() -> void:
	while speaker_dialogue.visible_characters < speaker_dialogue.get_total_character_count():
		speaker_dialogue.visible_characters += 1
		await get_tree().create_timer(typing_speed).timeout # wait for typing_speed units before going to next line
	
	is_typing = false


func _on_ready() -> void:
	show_dialogue("Snorlax", "Hello there. This text should type slowly.")
