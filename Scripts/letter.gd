extends CanvasLayer

signal done_reading

func _on_done_button_pressed() -> void:
	done_reading.emit()
