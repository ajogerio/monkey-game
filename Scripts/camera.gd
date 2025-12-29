extends Camera2D

@export var player_node: CharacterBody2D
@export var deadzone_world: float = 45  # world units

func _process(delta: float) -> void:
	if not player_node:
		return
	
	var viewport_width = get_viewport().size.x
	var viewport_left_edge_position = global_position.x - (viewport_width / 2)
	var player_distance_from_viewport_left_edge = player_node.global_position.x - viewport_left_edge_position
	
	if player_distance_from_viewport_left_edge > deadzone_world:
		global_position.x += player_node.velocity.x * delta
