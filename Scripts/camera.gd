extends Camera2D

@export var player_node: CharacterBody2D
@export var right_barrier_percent: float = 0.3
@export var left_barrier_percent: float = 0.1

var min_camera_x: float
var max_camera_x: float
var camera_bounds: Area2D

func set_camera_bounds(bounds: Area2D) -> void:
	camera_bounds = bounds
	var collision_shape := camera_bounds.get_node("Bounds Shape") as CollisionShape2D
	var rect_shape = collision_shape.shape as RectangleShape2D
	var rect_width = rect_shape.size.x
	var rect_center = collision_shape.global_position.x
	
	# Half the width of the rectangle goes to the left, and other half goes to the right
	min_camera_x = rect_center - rect_width / 2
	max_camera_x = (rect_center + rect_width / 2) - get_viewport_rect().size.x
	
func _process(delta: float) -> void:
	if not player_node:
		return
	
	var viewport_width = get_viewport_rect().size.x
	var right_barrier_of_deadzone = global_position.x + (viewport_width * right_barrier_percent)
	var left_barrier_of_deadzone = global_position.x + (viewport_width * left_barrier_percent)
	
	# make the camera pan to the right whenever the player is past the right barrier of the deadzone
	if player_node.global_position.x > right_barrier_of_deadzone and global_position.x < max_camera_x:
		global_position.x += player_node.velocity.x * delta
	elif player_node.global_position.x < left_barrier_of_deadzone and global_position.x > min_camera_x:
		global_position.x += player_node.velocity.x * delta
	
	# make sure the camera stays within bounds
	global_position.x = clamp(global_position.x, min_camera_x, max_camera_x)

func reset_camera():
	position = Vector2.ZERO
