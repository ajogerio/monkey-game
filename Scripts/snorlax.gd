extends Area2D

@onready var floating_e_key = $"Floating E Key"
@onready var dialogue_box = get_tree().get_first_node_in_group("dialogue_box")

var is_player_in_talk_range := false
var is_talking := false

var dialogue_data : Array[Dictionary] = [
	Dictionary({"speaker": "NPC", "text": "Hello there!"}),
	Dictionary({"speaker": "Player", "text": "Hi! Nice to meet you."}),
	Dictionary({"speaker": "NPC", "text": "Be careful out there."})
]

func _process(delta: float) -> void:
	if is_player_in_talk_range and !is_talking and Input.is_action_just_pressed("interact"):
		_start_dialogue()

func _on_body_entered(body: Node2D) -> void:
	if body.is_in_group("player"):
		print("player entered the interaction zone.")
		is_player_in_talk_range = true
		floating_e_key.visible = true

func _on_body_exited(body: Node2D) -> void:
	if body.is_in_group("player"):
		is_player_in_talk_range = false
		floating_e_key.visible = false

func _start_dialogue():
	floating_e_key.visible = false
	is_talking = true
	dialogue_box.show_dialogue(dialogue_data)

func _on_dialogue_box_dialogue_finished() -> void:
	is_talking = false
	if is_player_in_talk_range:
		floating_e_key.visible = true
