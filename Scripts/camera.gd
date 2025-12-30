extends Camera2D

@export var player_node: CharacterBody2D
@export var right_barrier_percent: float = 0.3
@export var left_barrier_percent: float = 0.1
	
func _process(delta: float) -> void:
	if not player_node:
		return
	
	var viewport_width = get_viewport_rect().size.x
	var right_barrier_of_deadzone = global_position.x + (viewport_width * right_barrier_percent)
	var left_barrier_of_deadzone = global_position.x + (viewport_width * left_barrier_percent)
	
	# make the camera pan to the right whenever the player is past the right barrier of the deadzone
	if player_node.position.x > right_barrier_of_deadzone || player_node.position.x < left_barrier_of_deadzone:
		global_position.x += player_node.velocity.x * delta
	else:
		# player is in between the barriers
		return
