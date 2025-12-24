extends CharacterBody2D

const SPEED = 300

func _physics_process(delta: float) -> void:
	velocity.x = 0
	
	if Input.is_action_pressed("move_left"):
		velocity.x -= SPEED
	
	if Input.is_action_pressed("move_right"):
		velocity.x += SPEED
	
	move_and_slide()
