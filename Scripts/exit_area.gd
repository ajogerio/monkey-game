extends Area2D

signal load_next_level

func _on_body_entered(body: Node2D) -> void:
	if body.is_in_group("player"):
		load_next_level.emit()
