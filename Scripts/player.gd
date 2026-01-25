extends CharacterBody2D

const HORIZONTAL_SPEED = 180
const GRAVITY_SPEED = 1000
const JUMP_SPEED = 300

# export allows us to modify the value in the inspector (right panel)
# drag the cookie bullet scene into the slot in the inspector
# so we have access to it now in the code
@export var cookie_bullet_scene: PackedScene

func _ready():
	# play animation
	$"Player Sprite"/AnimationPlayer.play("idle")

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

# the _unhandled_input function runs whenever there is a new input. 
# The input goes through UI first, then when its unhandled by the UI
# part, it checks the nodes one by one and asks if the input belongs
# to them. In this case, if we click, it belongs to us and we handle it
# below
func _unhandled_input(_event):
	if Input.is_action_just_pressed("shoot"):
		shoot()

func shoot() -> void:
	var cookie_bullet = cookie_bullet_scene.instantiate() # make a new instance of the cookie bullet
	cookie_bullet.global_position = $Muzzle.global_position # put the new bullet in the position of the muzzle
	cookie_bullet.direction = $Muzzle.global_position.direction_to(get_global_mouse_position()) # set the direction vector of the cookie_bullet to be the vector from the muzzle to the mouse position
	get_tree().current_scene.add_child(cookie_bullet)
