extends CharacterBody2D

func _on_hitbox_area_entered(area: Area2D) -> void:
	print("activated")
	if area.is_in_group("cookie_bullet"):
		print("Boss hit")
