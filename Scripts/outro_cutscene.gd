extends Node2D

@export var gifts_dialogue_filepath : String
@export var iloveyou_dialogue_filepath : String

func play_cutscene(player):
	player.controls_enabled = false
	
	await get_tree().create_timer(3.0).timeout

	# play the outro dialogue of gifts
	DialogueManagerAutoload.dialogue_box.show_dialogue(gifts_dialogue_filepath)
	await DialogueManagerAutoload.dialogue_finished

	# show the letter
	await show_letter()

	# show the last dialogue
	DialogueManagerAutoload.dialogue_box.show_dialogue(iloveyou_dialogue_filepath)
	await DialogueManagerAutoload.dialogue_finished

	# show the end text
	
	# show confetti

func show_letter():
	print("show letter")
