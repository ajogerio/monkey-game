extends CanvasLayer

@onready var animation: AnimationPlayer = $"AnimationPlayer"

func fade_out() -> void:
	animation.play("fade_out")
	await animation.animation_finished
	
func fade_in() -> void:
	animation.play("fade_in")
	await animation.animation_finished
