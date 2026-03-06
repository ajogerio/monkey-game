extends Node2D

@export var intro_dialogue_filepath: String

func play_intro(player):
	# disable player controls
	player.controls_enabled = false
	
	# set a timer for 3 seconds to soak up the scene
	await get_tree().create_timer(3.0).timeout
	
	# play arguing dialogue
	DialogueManagerAutoload.dialogue_box.show_dialogue(intro_dialogue_filepath)
	
	# monkeys enter the scene
	
	# monkeys grab aj
	# monkey dialogue plays
	# monkeys run away with aj to the right of the screen
	# cb dialogue plays
	# cb exits to the right
