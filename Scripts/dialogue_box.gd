extends Control

# references to the child nodes
@onready var speaker_name = $"Panel/MarginContainer/HBoxContainer/VBoxContainer/Speaker Name"
@onready var speaker_dialogue = $"Panel/MarginContainer/HBoxContainer/VBoxContainer/Speaker Dialogue"
@onready var player_portrait = $"Panel/MarginContainer/HBoxContainer/Player Portrait"
@onready var npc_portrait = $"Panel/MarginContainer/HBoxContainer/NPC Portrait"

var typing_speed := 0.03
var is_typing := false

var dialogue_lines : Array[Dictionary] = []
var current_line_index := 0

func show_dialogue(lines: Array[Dictionary]) -> void:
	visible = true
	
	dialogue_lines = lines # assign it to the global variable so all functions have access
	current_line_index = 0
	_show_current_line()
	
func _show_current_line():
	var line = dialogue_lines[current_line_index]
	
	if line["speaker"] == "Player":
		player_portrait.visible = true
		npc_portrait.visible = false
	else:
		player_portrait.visible = false
		npc_portrait.visible = true
	
	# set speaker name and text
	speaker_name.text = line["speaker"]
	speaker_dialogue.clear()
	speaker_dialogue.append_text(line["text"])
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
				DialogueManagerAutoload.dialogue_finished.emit()

func _on_ready() -> void:
	DialogueManagerAutoload.dialogue_box = self
	visible = false
