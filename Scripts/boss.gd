extends CharacterBody2D

@export var rock_scene: PackedScene

signal boss_hit
signal boss_dizzy

var rocks_thrown := 0
var rocks_to_throw := 0

func _on_hitbox_area_entered(area: Area2D) -> void:
	if area.is_in_group("cookie_bullet"):
		# make bullet disappear
		area.queue_free()
		
		# send signal to the level that the boss was hit
		boss_hit.emit()
		

func _on_timer_timeout() -> void:
	if rocks_thrown != rocks_to_throw:
		throw_rock()
		rocks_thrown += 1
	else:
		$Timer.stop()
		# play the animation to make boss dizzy
		boss_dizzy.emit()

func throw_rock():
	var rock = rock_scene.instantiate()
	rock.global_position = $"Attack Origin".global_position
	get_tree().current_scene.add_child(rock)


func _on_boss_level_wake_up(current_hp) -> void:
	# play aniimation to stop the boss from being dizzy
	# play a roar or something
	rocks_thrown = 0
	if current_hp >= 4:
		$Timer.wait_time = 3
		rocks_to_throw = 3
	if current_hp < 4 and current_hp > 2:
		$Timer.wait_time = 2
		rocks_to_throw = 5
		print("speed up 2")
	if current_hp <= 2:
		$Timer.wait_time = 1
		print("speed up 1")
		rocks_to_throw = 10
	$Timer.start()
