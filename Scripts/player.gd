extends CharacterBody2D

const HORIZONTAL_SPEED = 300
const GRAVITY_SPEED = 1000
const JUMP_SPEED = 300

func _ready():
	# play animation
	$Sprite2D/AnimationPlayer.play("idle")

func _physics_process(delta: float) -> void:
	# horizontal movement:
	velocity.x = 0 # make sure that movement is always reset to 0 so it does not move infinitely
	
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
