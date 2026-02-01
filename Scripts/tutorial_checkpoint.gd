extends Area2D

@export var checkpoint_name := "Checkpoint1"
@export var dialogue_filepath: String

@onready var arrow_indicator := $"Arrow Indicator"

func _ready():
	# Hide the arrow indicator at start
	arrow_indicator.hide_arrow()
	SignalBusAutoload.connect("show_arrow_signal", Callable(self, "_on_show_arrow"))
	
func _on_body_entered(body: Node2D) -> void:
	if body.is_in_group("player"):
		DialogueManagerAutoload.dialogue_box.show_dialogue(dialogue_filepath)
		
func _on_show_arrow(name: String):
	if name == checkpoint_name:
		arrow_indicator.show_arrow()
