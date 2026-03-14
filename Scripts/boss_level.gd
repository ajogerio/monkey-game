extends Node2D

signal wake_up(boss_hp)
signal load_next_level

@export var intro_dialogue_filepath: String

var boss_hp := 5
var damage_amount := 1
var is_taking_damage := false
var player: Node2D

@onready var boss := $Boss
@onready var full_hearts := $"Boss Hearts/Control/Full Hearts".get_children()
@onready var dialogue_timer := $"Dialogue Start Timer"
@onready var boss_hearts_ui := $"Boss Hearts"
@onready var anim = $"Boss/Boss Sprite/AnimationPlayer"


func _ready() -> void:
	boss.connect("boss_hit", _on_boss_hit)
	boss.connect("boss_dizzy", _on_boss_dizzy)
	boss_hearts_ui.visible = false
	anim.play("idle")


func play_boss_intro(p: Node2D):
	player = p

	player.controls_enabled = false

	await get_tree().create_timer(3.0).timeout

	DialogueManagerAutoload.dialogue_box.show_dialogue(intro_dialogue_filepath)
	await DialogueManagerAutoload.dialogue_finished

	player.controls_enabled = true
	wake_up.emit(boss_hp)
	boss_hearts_ui.visible = true


func _on_boss_hit():
	if is_taking_damage:
		boss_hp -= damage_amount
		full_hearts[boss_hp].visible = false
		anim.play("hit")
		await anim.animation_finished
		
		is_taking_damage = false

		if boss_hp > 0 and boss_hp < full_hearts.size():
			anim.play("idle")
			wake_up.emit(boss_hp)
		else:
			boss_dies()


func _on_boss_dizzy():
	is_taking_damage = true
	anim.play("dizzy")


func boss_dies():
	anim.play("dead")
	is_taking_damage = false

	player.controls_enabled = false

	# set a timer for 3 seconds
	await get_tree().create_timer(3.0).timeout
	print("timeout occured")

	# exit to the outro level
	load_next_level.emit()
