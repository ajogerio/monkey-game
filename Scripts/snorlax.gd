extends Area2D

@onready var floating_e_key = $"Floating E Key"

var is_player_in_talk_range := false
var is_talking := false

func _process(delta: float) -> void:
	if is_player_in_talk_range and !is_talking and Input.is_action_just_pressed("interact"):
		_start_dialogue()

func _on_body_entered(body: Node2D) -> void:
	if body.is_in_group("player"):
		is_player_in_talk_range = true
		floating_e_key.visible = true

func _on_body_exited(body: Node2D) -> void:
	if body.is_in_group("player"):
		is_player_in_talk_range = false
		floating_e_key.visible = false

func _start_dialogue():
	floating_e_key.visible = false
	is_talking = true
	DialogueManagerAutoload.dialogue_box.show_dialogue("res://Resources/tutorial_snorlax_meetup.json")

func _on_dialogue_box_dialogue_finished() -> void:
	is_talking = false
	if is_player_in_talk_range:
		floating_e_key.visible = true
	SignalBusAutoload.start_checkpoint_chain.emit("Checkpoint1")

func _ready():
	DialogueManagerAutoload.dialogue_finished.connect(_on_dialogue_box_dialogue_finished)
