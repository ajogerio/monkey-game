extends CharacterBody2D

const HORIZONTAL_SPEED = 150
const GRAVITY_SPEED = 1000
const JUMP_SPEED = 350

@export var cookie_bullet_scene: PackedScene

var controls_enabled := true
var knockback_velocity: Vector2 = Vector2.ZERO
var is_knocked_back := false
var knockback_decay := 800.0

@onready var anim = $"Player Sprite/AnimationPlayer"


func _ready():
	# play animation
	anim.play("idle")


func _physics_process(delta: float) -> void:
	if not controls_enabled:
		velocity = Vector2.ZERO
		move_and_slide()
		return

	if is_knocked_back:
		velocity = knockback_velocity

		knockback_velocity = knockback_velocity.move_toward(Vector2.ZERO, knockback_decay * delta)

		if knockback_velocity.length() < 10:
			is_knocked_back = false

		move_and_slide()
		return

	# horizontal movement:
	velocity.x = 0  # make sure that movement is always reset to 0 so it does not move infinitely

	if Input.is_action_pressed("move_left"):
		velocity.x -= HORIZONTAL_SPEED

	if Input.is_action_pressed("move_right"):
		velocity.x += HORIZONTAL_SPEED

	# gravity movement:
	if not is_on_floor():
		velocity.y += GRAVITY_SPEED * delta

	# jumping:
	if Input.is_action_just_pressed("jump"):
		velocity.y = -JUMP_SPEED  # negative value so that it goes upwards (+y is up and -y is down)

	move_and_slide()


# the _unhandled_input function runs whenever there is a new input.
# The input goes through UI first, then when its unhandled by the UI
# part, it checks the nodes one by one and asks if the input belongs
# to them. In this case, if we click, it belongs to us and we handle it
# below
func _unhandled_input(_event):
	if not controls_enabled:
		return

	if Input.is_action_just_pressed("shoot"):
		shoot()


func shoot() -> void:
	var cookie_bullet = cookie_bullet_scene.instantiate()
	cookie_bullet.global_position = $Muzzle.global_position
	# set the direction vector of the cookie_bullet towards the cursor
	cookie_bullet.direction = $Muzzle.global_position.direction_to(get_global_mouse_position())
	get_tree().current_scene.add_child(cookie_bullet)


func take_rock_hit(from_position: Vector2):
	is_knocked_back = true

	var direction = (global_position - from_position).normalized()
	knockback_velocity = direction * 250
