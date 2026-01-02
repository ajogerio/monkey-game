extends CharacterBody2D

const GRAVITY_SPEED = 1000

func _ready() -> void:
	$"Monkey Sprite"/AnimationPlayer.play("idle")
func _physics_process(delta: float) -> void:
	if not is_on_floor():
		velocity.y += GRAVITY_SPEED * delta
	
	move_and_slide()
