extends Node2D

const TUTORIAL_LEVEL: PackedScene = preload("res://Scenes/Levels/tutorial_level_scene.tscn")

@onready var level_container = $Level
@onready var player = $Player

func _on_ready() -> void:
	load_level(TUTORIAL_LEVEL)

func load_level(scene_path: PackedScene):
	# clear any existing levels
	for child in level_container.get_children():
		child.queue_free()
	
