extends Area2D

const JUNGLE_LEVEL: PackedScene = preload("res://Scenes/Levels/jungle_level_scene.tscn")
signal load_next_level(next_level : PackedScene)

func _on_body_entered(body: Node2D) -> void:
	if body.is_in_group("player"):
		load_next_level.emit(JUNGLE_LEVEL)
	
