extends Node2D

@onready var boss := $Boss
@onready var full_hearts := $"Boss Hearts/Control/Full Hearts".get_children()

func _ready() -> void:
	boss.connect("boss_hit", _on_boss_hit)

func _on_boss_hit():
	print("boss hit")
