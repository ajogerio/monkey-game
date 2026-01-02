extends CharacterBody2D

const GRAVITY_SPEED = 1000
const HORIZONTAL_SPEED = 1

var start_position : float
var is_pacing_right : bool = false
var is_pacing_left : bool = false

func _ready() -> void:
	$"Monkey Sprite"/AnimationPlayer.play("idle_left")
func _physics_process(delta: float) -> void:
	if not is_on_floor():
		velocity.y += GRAVITY_SPEED * delta
	
	if is_pacing_right:
		velocity.x += HORIZONTAL_SPEED
		
		if position.x - start_position >= 50:
			velocity.x = 0
			is_pacing_right = false
			$"Monkey Sprite"/AnimationPlayer.play("idle_left")
	
	if is_pacing_left:
		velocity.x = HORIZONTAL_SPEED
		
	move_and_slide()
	
# set a timer
func _on_timer_timeout():
	# after the timer play the walk animation
	$"Monkey Sprite"/AnimationPlayer.play("walk_right")
	
	# make monkey pace to the right
	start_position = position.x
	is_pacing_right = true
	# play the idle animation
	# wait for the timer again
	# play the walk animation
	# move the monkey to the left
	# stop
	# repeat step one
