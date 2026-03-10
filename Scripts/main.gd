extends Node2D

const INTRO_LEVEL: PackedScene = preload("res://Scenes/Levels/intro_cutscene.tscn")
const TUTORIAL_LEVEL: PackedScene = preload("res://Scenes/Levels/tutorial_level_scene.tscn")
const JUNGLE_LEVEL: PackedScene = preload("res://Scenes/Levels/jungle_level_scene.tscn")
const BOSS_LEVEL: PackedScene = preload("res://Scenes/Levels/boss_level_scene.tscn")
const OUTRO_LEVEL: PackedScene = preload("res://Scenes/Levels/outro_cutscene.tscn")

var levels := []
var current_level_index := 0

@onready var level_container = $Level
@onready var player = $Player
@onready var transition = $Transition


func _ready() -> void:
	levels = [
		OUTRO_LEVEL,
		INTRO_LEVEL,
		TUTORIAL_LEVEL,
		JUNGLE_LEVEL,
		BOSS_LEVEL,
	]
	load_level_by_index(0, true)


func load_level_by_index(index: int, skip_fade: bool = false) -> void:
	current_level_index = index
	load_level(levels[index], skip_fade)


func load_level(level_scene: PackedScene, skip_fade: bool = false) -> void:
	player.controls_enabled = false

	if not skip_fade:
		await transition.fade_out()

	# clear any existing levels
	for child in level_container.get_children():
		child.queue_free()

	# instantiate the level scene into the scene tree
	var level_instance: Node = level_scene.instantiate()
	level_container.add_child(level_instance)

	# listen for the next level signal
	if level_instance.has_node("Exit Area"):
		var exit = level_instance.get_node("Exit Area")
		exit.load_next_level.connect(_on_load_next_level)

	if level_instance.has_signal("load_next_level"):
		level_instance.load_next_level.connect(_on_load_next_level)

	# assign camera bounds to camera
	if level_instance.has_node("Camera Bounds"):
		var camera_bounds_node = level_instance.get_node("Camera Bounds") as Area2D
		$Camera2D.set_camera_bounds(camera_bounds_node)

	$Camera2D.reset_camera()

	# move the player to the spawn point
	if level_instance.has_node("Player Spawn"):
		var spawn := level_instance.get_node("Player Spawn") as Marker2D
		if spawn:
			player.global_position = spawn.global_position

	if not skip_fade:
		await transition.fade_in()

	# if there are any intros to the scene, play those first
	if level_instance.has_method("play_boss_intro"):
		await level_instance.play_boss_intro(player)
	elif level_instance.has_method("play_intro"):
		await level_instance.play_intro(player)
	elif level_instance.has_method("play_cutscene"):
		await level_instance.play_cutscene(player, transition)
	else:
		player.controls_enabled = true


func _on_load_next_level():
	var next_index = current_level_index + 1

	if next_index >= levels.size():
		return

	load_level_by_index(next_index)
