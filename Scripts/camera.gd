extends Camera2D

@export var player_node: CharacterBody2D
@export var camera_bounds: Node2D
@export var right_barrier_percent: float = 0.3
@export var left_barrier_percent: float = 0.1

var min_camera_x: float
var max_camera_x: float

func _ready() -> void:
	var shape := camera_bounds.get_node("CollisionShape2d").shape as RectangleShape2D
	var rect_size := shape.size
	var rect_center := camera_bounds.global_position.x
	var rect_width := shape.size.x
	
	# Half the width of the rectangle goes to the left, and other half goes to the right
	min_camera_x = rect_center - rect_width / 2
	max_camera_x = rect_center + rect_width / 2
	
func _process(delta: float) -> void:
	if not player_node:
		return
	
	var viewport_width = get_viewport_rect().size.x
	var right_barrier_of_deadzone = global_position.x + (viewport_width * right_barrier_percent)
	var left_barrier_of_deadzone = global_position.x + (viewport_width * left_barrier_percent)
	
	# make the camera pan to the right whenever the player is past the right barrier of the deadzone
	if player_node.position.x > right_barrier_of_deadzone || player_node.position.x < left_barrier_of_deadzone:
		global_position.x += player_node.velocity.x * delta
