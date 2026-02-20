extends CharacterBody2D

@export var speed: float = 200.0

func _physics_process(delta: float) -> void:
	velocity.x = -speed # negative means move left
	move_and_slide()

func _on_visible_on_screen_notifier_2d_screen_exited() -> void:
	queue_free() # remove rock when it exits
