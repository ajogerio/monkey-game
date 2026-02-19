extends Node2D

@onready var boss := $Boss
@onready var full_hearts := $"Boss Hearts/Control/Full Hearts".get_children()

var boss_hp := 5
var damage_amount := 1

func _ready() -> void:
	boss.connect("boss_hit", _on_boss_hit)

func _on_boss_hit():
	boss_hp -= damage_amount
	
	if boss_hp >= 0 and boss_hp < full_hearts.size():
		full_hearts[boss_hp].visible = false
	
