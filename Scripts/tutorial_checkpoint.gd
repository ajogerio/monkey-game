extends Area2D

@export var checkpoint_name: String = ""
@export var next_checkpoint: String= ""
@export var dialogue_filepath: String

@onready var arrow_indicator := $"Arrow Indicator"

var is_active := false
var has_been_completed := false
var waiting_for_dialogue := false

func _ready():
	# Hide the arrow indicator at start
	arrow_indicator.hide_arrow()
	
	SignalBusAutoload.show_arrow_signal.connect(Callable(self, "_on_show_arrow"))
	SignalBusAutoload.start_checkpoint_chain.connect(Callable(self, "_on_start_checkpoint_chain"))
	DialogueManagerAutoload.dialogue_finished.connect(Callable(self, "_on_dialogue_finished"))
	
func _on_body_entered(body: Node2D) -> void:
	if not is_active or has_been_completed:
		return
	
	if body.is_in_group("player"):
		has_been_completed = true
		is_active = false
		arrow_indicator.hide_arrow()
		
		if dialogue_filepath != "":
			waiting_for_dialogue = true
			DialogueManagerAutoload.dialogue_box.show_dialogue(dialogue_filepath)
			
func _on_show_arrow(name: String):
	if name == checkpoint_name:
		is_active = true
		arrow_indicator.show_arrow()

func _on_start_checkpoint_chain(first_checkpoint: String):
	if checkpoint_name == first_checkpoint:
		is_active = true
		arrow_indicator.show_arrow()
		
func _on_dialogue_finished():
	if not waiting_for_dialogue:
		return
		
	waiting_for_dialogue = false
	
	if next_checkpoint != "":
		SignalBusAutoload.show_arrow_signal.emit(next_checkpoint)
