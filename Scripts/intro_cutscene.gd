extends Node2D

@export var intro_dialogue_filepath: String
@export var monkey_arrival_dialogue_filepath: String
@export var cb_chase_after_dialogue_filepath: String

@onready var aj := $"Aj"
@onready var monkey_scene := preload("res://Scenes/enemy_monkey_scene.tscn")
var monkeys := []
var monkeys_to_spawn = 3

func play_intro(player):
	# disable player controls
	player.controls_enabled = false
	
	# set a timer for 3 seconds to soak up the scene
	await get_tree().create_timer(3.0).timeout
	
	# play arguing dialogue
	DialogueManagerAutoload.dialogue_box.show_dialogue(intro_dialogue_filepath)
	await DialogueManagerAutoload.dialogue_finished
	
	# monkeys enter the scene
	await enter_monkeys()
	
	# monkeys grab aj
	await monkeys_grab_aj()
	
	# monkey dialogue plays
	DialogueManagerAutoload.dialogue_box.show_dialogue(monkey_arrival_dialogue_filepath)
	await DialogueManagerAutoload.dialogue_finished
	
	# monkeys run away with aj to the right of the screen
	await monkeys_exit()
	
	# cb dialogue plays
	DialogueManagerAutoload.dialogue_box.show_dialogue(cb_chase_after_dialogue_filepath)
	await DialogueManagerAutoload.dialogue_finished
	
	# cb exits to the right
	cb_exits(player)

func enter_monkeys():
	# clear the monkey list
	monkeys.clear()
	
	var viewport_width = get_viewport_rect().size.x
	var target_x_base = aj.global_position.x + 50
	var spacing = 30 # pixels between each monkey
	
	# spawn the monkeys
	for i in range (monkeys_to_spawn):
		var monkey = monkey_scene.instantiate()
		add_child(monkey)
		
		monkey.global_position = Vector2(viewport_width + 50, aj.global_position.y)
		monkeys.append(monkey)
		
		var target_x = target_x_base - (i * spacing)
		
		var tween  = create_tween()
		tween.tween_property(monkey, "global_position", Vector2(target_x, monkey.global_position.y), 1.5).set_trans(Tween.TRANS_SINE).set_ease(Tween.EASE_IN_OUT)
		await tween.finished

func monkeys_grab_aj():
	if monkeys.size() < 2:
		return
	
	var second_monkey = monkeys[1]
	
	# rotate aj slightly upwards
	var rotate_tween = create_tween()
	rotate_tween.tween_property(aj, "rotation", 1.5, 1).set_trans(Tween.TRANS_SINE).set_ease(Tween.EASE_IN_OUT)
	await rotate_tween.finished
	
	var target_position = second_monkey.global_position + Vector2(0, -20)
	var move_tween = create_tween()
	move_tween.tween_property(aj, "global_position", target_position, 0.8).set_trans(Tween.TRANS_SINE).set_ease(Tween.EASE_IN_OUT)
	await move_tween.finished

func monkeys_exit():
	var viewport_width = get_viewport_rect().size.x
	var exit_x = viewport_width + 100
	
	var tween = create_tween()
	
	for i in range(monkeys.size()):
		var monkey = monkeys[i]
		
		tween.parallel().tween_property(
			monkey,
			"global_position",
			Vector2(exit_x, monkey.global_position.y),
			2.0
		).set_trans(Tween.TRANS_SINE).set_ease(Tween.EASE_IN_OUT)
		
	if monkeys.size() > 2:
		var carrier = monkeys[1]
		var aj_target = Vector2(exit_x, carrier.global_position.y - 20)
		
		tween.parallel().tween_property(
			aj,
			"global_position",
			aj_target,
			2.0
		).set_trans(Tween.TRANS_SINE).set_ease(Tween.EASE_IN_OUT)
	
	await tween.finished

func cb_exits(player):
	var viewport_width = get_viewport_rect().size.x
	var exit_x = viewport_width + 100
	
	var tween = create_tween()
	
	tween.tween_property(player, "global_position", Vector2(exit_x, player.global_position.y), 2.0).set_trans(Tween.TRANS_SINE).set_ease(Tween.EASE_IN_OUT)
	await tween.finished
