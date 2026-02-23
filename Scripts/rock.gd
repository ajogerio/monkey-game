extends CharacterBody2D

@export var speed: float = 200.0

func _physics_process(delta: float) -> void:
	velocity.x = -speed # negative means move left
	
	# remove rock if it hits player
	var collision = move_and_collide(velocity * delta)
	
	if collision:
		var collider = collision.get_collider()
		
		if collider.is_in_group("player"):
			collider.take_rock_hit(global_position)
			queue_free()
	

func _on_visible_on_screen_notifier_2d_screen_exited() -> void:
	queue_free() # remove rock when it exits screen
