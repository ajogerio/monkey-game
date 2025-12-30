extends Camera2D

@export var player_node: CharacterBody2D
@export var deadzone_percent: float = 0.3
@export var camera_follow_speed: float = 20.0

func _process(delta: float) -> void:
	if not player_node:
		return
	
	var viewport_width = get_viewport_rect().size.x
	var move_camera_when_player_passes_this_barrier = global_position.x + (viewport_width * deadzone_percent)
	var player_position_x = player_node.position.x
	
	if player_position_x > move_camera_when_player_passes_this_barrier:
		var overshoot_distance_of_player_from_barrier = player_node.global_position.x - (viewport_width * deadzone_percent)
		
		# smoothly transition the camera to close the overshoot of the player from the barrier
		global_position.x = lerp(global_position.x, overshoot_distance_of_player_from_barrier, camera_follow_speed * delta)
