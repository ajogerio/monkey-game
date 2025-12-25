extends Area2D


@export var SPEED: float = 600.0
var direction: Vector2 = Vector2.ZERO # start with 0 direction

func _physics_process(delta: float) -> void:
	# Area2D does not come with a "velocity" variable so we have to manually add to
	# the position vector. Unlike Character2D which has it built in and you could just do 
	# velocity = speed * direction, then move_and_slide() does the adding to position
	position += direction * SPEED * delta 
