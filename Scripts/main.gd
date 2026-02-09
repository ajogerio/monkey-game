extends Node2D

const TUTORIAL_LEVEL: PackedScene = preload("res://Scenes/Levels/tutorial_level_scene.tscn")

@onready var level_container = $Level
@onready var player = $Player

func _ready() -> void:
	load_level(TUTORIAL_LEVEL)

func load_level(level_scene: PackedScene):
	# clear any existing levels
	for child in level_container.get_children():
		child.queue_free()
	
	# instantiate the level scene into the scene tree
	var level_instance: Node = level_scene.instantiate()
	level_container.add_child(level_instance)
	
	# listen for the next level signal
	if level_instance.has_signal("load_next_level"):
		level_instance.load_next_level.connect(_on_load_next_level)
		
	# assign camera bounds to camera
	if level_instance.has_node("Camera Bounds"):
		var camera_bounds_node = level_instance.get_node("Camera Bounds") as Area2D
		$Camera2D.set_camera_bounds(camera_bounds_node)
	
	# move the player to the spawn point
	if level_instance.has_node("Player Spawn"):
		var spawn := level_instance.get_node("Player Spawn") as Marker2D
		if spawn:
			player.global_position = spawn.global_position

func _on_load_next_level(next_level : PackedScene):
	$Camera2D.reset_camera()
	load_level(next_level)
