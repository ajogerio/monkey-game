extends Area2D

@export var dialogue_filepath: String

func _on_body_entered(body: Node2D) -> void:
	if body.is_in_group("player"):
		DialogueManagerAutoload.dialogue_box.show_dialogue(dialogue_filepath)
