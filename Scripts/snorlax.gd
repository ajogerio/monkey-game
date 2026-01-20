extends Area2D

@onready var floating_e_key = $"Floating E Key"

var is_player_in_talk_range := false

func _on_body_entered(body: Node2D) -> void:
	if body.is_in_group("player"):
		print("player entered the interaction zone.")
		is_player_in_talk_range = true
		floating_e_key.visible = true

func _on_body_exited(body: Node2D) -> void:
	if body.is_in_group("player"):
		is_player_in_talk_range = false
		floating_e_key.visible = false
