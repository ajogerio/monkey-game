extends Node2D

@onready var boss := $Boss
@onready var full_hearts := $"Boss Hearts/Control/Full Hearts".get_children()

var boss_hp := 5
var damage_amount := 1
var is_taking_damage := false

signal wake_up

func _ready() -> void:
	boss.connect("boss_hit", _on_boss_hit)
	boss.connect("boss_dizzy", _on_boss_dizzy)

func _on_boss_hit():
	if is_taking_damage:
		boss_hp -= damage_amount
		
		if boss_hp >= 0 and boss_hp < full_hearts.size():
			full_hearts[boss_hp].visible = false
			# play boss hit animation
			is_taking_damage = false
			wake_up.emit()
		
func _on_boss_dizzy():
	is_taking_damage = true
	print("boss is dizzy")
	
	
