extends CharacterBody2D

@export var rock_scene: PackedScene

signal boss_hit

func _on_hitbox_area_entered(area: Area2D) -> void:
	if area.is_in_group("cookie_bullet"):
		# make bullet disappear
		area.queue_free()
		
		# send signal to the level that the boss was hit
		boss_hit.emit()
		

func _on_timer_timeout() -> void:
	throw_rock()
	print("threw rock")

func throw_rock():
	print("Ran func")
	var rock = rock_scene.instantiate()
	rock.global_position = $"Attack Origin".global_position
	get_tree().current_scene.add_child(rock)
