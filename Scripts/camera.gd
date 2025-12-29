extends Camera2D

@export var player_node: Node2D
@export var deadzone_percent: float = 0.4


func _process(delta: float) -> void:
	if not player_node:
		return
	
	var viewport_width = get_viewport().size.x
	var deadzone_width = viewport_width * deadzone_percent
	
	if player_node.global_position.x > deadzone_width:
		global_position.x += player_node.velocity.x * delta
