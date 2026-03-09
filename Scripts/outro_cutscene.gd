extends Node2D

@export var gifts_dialogue_filepath : String
@export var iloveyou_dialogue_filepath : String

@onready var letter_scene: PackedScene = preload("res://Scenes/letter_scene.tscn")
@onready var the_end_text_scene: PackedScene = preload("res://Scenes/the_end_text_scene.tscn")

func play_cutscene(player, transition):
	player.controls_enabled = false
	
	await get_tree().create_timer(3.0).timeout

	# play the outro dialogue of gifts
	DialogueManagerAutoload.dialogue_box.show_dialogue(gifts_dialogue_filepath)
	await DialogueManagerAutoload.dialogue_finished
	
	await transition.fade_out()
	
	# show the letter
	await show_letter()
	
	await transition.fade_in()

	# show the last dialogue
	DialogueManagerAutoload.dialogue_box.show_dialogue(iloveyou_dialogue_filepath)
	await DialogueManagerAutoload.dialogue_finished

	# show "the end"
	var the_end_text = the_end_text_scene.instantiate()
	get_tree().current_scene.add_child(the_end_text)
	
	# show confetti

func show_letter():
	var letter = letter_scene.instantiate()
	get_tree().current_scene.add_child(letter)
	await letter.done_reading
	letter.queue_free()
