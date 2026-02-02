extends Area2D

@export var checkpoint_name: String = ""
@export var next_checkpoint: String= ""
@export var dialogue_filepath: String

@onready var arrow_indicator := $"Arrow Indicator"

func _ready():
	# Hide the arrow indicator at start
	arrow_indicator.hide_arrow()
	
	SignalBusAutoload.show_arrow_signal.connect(Callable(self, "_on_show_arrow"))
	DialogueManagerAutoload.dialogue_finished.connect(Callable(self, "_on_dialogue_finished"))
	
func _on_body_entered(body: Node2D) -> void:
	if body.is_in_group("player"):
		DialogueManagerAutoload.dialogue_box.show_dialogue(dialogue_filepath)
		
func _on_show_arrow(name: String):
	if name == checkpoint_name:
		arrow_indicator.show_arrow()
		
func _on_dialogue_finished():
	if next_checkpoint != "":
		SignalBusAutoload.show_arrow_signal.emit(next_checkpoint)
