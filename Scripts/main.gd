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
	
	# move the player to the spawn point
	if level_instance.has_node("Player Spawn"):
		var spawn := level_instance.get_node("Player Spawn") as Marker2D
		if spawn:
			player.global_position = spawn.global_position
