extends CharacterBody2D

const GRAVITY_SPEED = 1000
const HORIZONTAL_SPEED = 50
const PACE_DISTANCE = 50

var start_position : float
var is_pacing_right : bool = false
var is_pacing_left : bool = false
var pace_direction = "right"

func _ready() -> void:
	$"Monkey Sprite"/AnimationPlayer.play("idle_left")
func _physics_process(delta: float) -> void:
	if not is_on_floor():
		velocity.y += GRAVITY_SPEED * delta
	
	if is_pacing_right:
		velocity.x = HORIZONTAL_SPEED
		
		if position.x - start_position >= PACE_DISTANCE:
			velocity.x = 0
			is_pacing_right = false
			$"Monkey Sprite"/AnimationPlayer.play("idle")
			pace_direction = "left"
	
	if is_pacing_left:
		velocity.x = -HORIZONTAL_SPEED
		
		if position.x - start_position <= -PACE_DISTANCE:
			velocity.x = 0
			is_pacing_left = false
			$"Monkey Sprite"/AnimationPlayer.play("idle_left")
			pace_direction = "right"
		
	move_and_slide()
	
# set a timer
func _on_timer_timeout():
	if not is_pacing_right && not is_pacing_left:
		start_position = position.x
		if pace_direction == "right":
			# make monkey pace to the right
			is_pacing_right = true
			$"Monkey Sprite"/AnimationPlayer.play("walk_right")
		if pace_direction == "left":
			is_pacing_left = true
			$"Monkey Sprite"/AnimationPlayer.play("walk_left")
