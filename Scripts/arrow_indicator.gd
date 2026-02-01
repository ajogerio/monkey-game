extends Node2D

@export var float_height := 10.0
@export var float_time := 0.8

var start_y: float

func _ready():
	start_y = position.y
	start_hover()

func start_hover():
	var tween = create_tween()
	
	tween.set_loops() # make this tween run forever
	
	tween.tween_property(
		self,
		"position:y",
		start_y - float_height,
		float_time
	).set_trans(Tween.TRANS_SINE).set_ease(Tween.EASE_IN_OUT)
	
	tween.tween_property(
		self,
		"position:y",
		start_y,
		float_time
	).set_trans(Tween.TRANS_SINE).set_ease(Tween.EASE_IN_OUT)

func show_arrow():
	visible = true
	
func hide_arrow():
	visible = false
