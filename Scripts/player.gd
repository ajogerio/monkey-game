extends CharacterBody2D

const HORIZONTAL_SPEED = 300
const GRAVITY_SPEED = 1000
const JUMP_SPEED = 300

func _physics_process(delta: float) -> void:
	# horizontal movement:
	velocity.x = 0
	
	if Input.is_action_pressed("move_left"):
		velocity.x -= HORIZONTAL_SPEED
	
	if Input.is_action_pressed("move_right"):
		velocity.x += HORIZONTAL_SPEED
	
	# gravity movement:
	if not is_on_floor():
		velocity.y += GRAVITY_SPEED * delta
	
	# jumping:
	if Input.is_action_just_pressed("jump"):
		velocity.y = -JUMP_SPEED # negative value so that it goes upwards (+y is up and -y is down)
		
	move_and_slide()
