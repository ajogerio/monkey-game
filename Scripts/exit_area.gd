extends Area2D
const JUNGLE_LEVEL: PackedScene = preload("res://Scenes/Levels/jungle_level_scene.tscn")

func _on_body_entered(body: Node2D) -> void:
	if body.is_in_group("player"):
		change_level()
		
func change_level():
	var level_manager = get_tree().get_nodes_in_group("level_manager")
	if level_manager.size() > 0:
		level_manager[0].load_level(JUNGLE_LEVEL);
