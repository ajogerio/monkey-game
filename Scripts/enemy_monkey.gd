extends CharacterBody2D

const GRAVITY_SPEED = 1000

func _ready() -> void:
	$"Monkey Sprite"/AnimationPlayer.play("idle_left")
func _physics_process(delta: float) -> void:
	if not is_on_floor():
		velocity.y += GRAVITY_SPEED * delta
	
	move_and_slide()
	
# set a timer
func _on_timer_timeout():
	# after the timer play the walk animation
	$"Monkey Sprite"/AnimationPlayer.play("walk_right")
	# move the monkey to the right 
	# stop 
	# play the idle animation
	# wait for the timer again
	# play the walk animation
	# move the monkey to the left
	# stop
	# repeat step one
