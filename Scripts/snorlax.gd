extends Area2D

var is_player_in_talk_range := false

func _on_body_entered(body: Node2D) -> void:
	if body.is_in_group("player"):
		print("player entered the interaction zone.")
		is_player_in_talk_range = true
		
