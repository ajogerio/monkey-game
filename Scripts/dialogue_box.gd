extends Control

# references to the child nodes
@onready var speaker_name = $"Panel/MarginContainer/HBoxContainer/VBoxContainer/Speaker Name"
@onready var speaker_dialogue = $"Panel/MarginContainer/HBoxContainer/VBoxContainer/Speaker Dialogue"
@onready var player_portrait = $"Panel/MarginContainer/HBoxContainer/Player Portrait"
@onready var npc_portrait = $"Panel/MarginContainer/HBoxContainer/NPC Portrait"

var typing_speed := 0.03
var is_typing := false

var dialogue_lines : Array[String] = []
var current_line_index := 0

func show_dialogue(speaker: String, lines: Array[String]) -> void:
	visible = true
	speaker_name.text = speaker
	
	dialogue_lines = lines # assign it to the global variable so all functions have access
	current_line_index = 0
	_show_current_line()
	
func _show_current_line():
	speaker_dialogue.clear()
	speaker_dialogue.append_text(dialogue_lines[current_line_index])
	speaker_dialogue.visible_characters = 0
	is_typing = true
	_start_typing()

func _start_typing() -> void:
	while speaker_dialogue.visible_characters < speaker_dialogue.get_total_character_count():
		speaker_dialogue.visible_characters += 1
		await get_tree().create_timer(typing_speed).timeout # wait for typing_speed units before going to next line
	
	is_typing = false

func _unhandled_input(event: InputEvent) -> void:
	if not visible:
		return
	
	if event.is_action_pressed("ui_accept"):
		if is_typing:
			# finish typing instantly
			speaker_dialogue.visible_characters = speaker_dialogue.get_total_character_count()
			is_typing = false
		else:
			# go to the next line if available
			current_line_index += 1
			if current_line_index < dialogue_lines.size():
				_show_current_line()
			else:
				# end of dialogue
				visible = false


func _on_ready() -> void:
	show_dialogue("Snorlax", ["Hello there. This text should type slowly.", "This is the next line of dialogue from Snorlax."])
