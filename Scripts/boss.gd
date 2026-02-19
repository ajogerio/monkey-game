extends CharacterBody2D

signal boss_hit

func _on_hitbox_area_entered(area: Area2D) -> void:
	if area.is_in_group("cookie_bullet"):
		# make bullet disappear
		area.queue_free()
		
		# send signal to the level that the boss was hit
		boss_hit.emit()
		
