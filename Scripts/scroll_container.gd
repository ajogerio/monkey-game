extends ScrollContainer


func _ready() -> void:
	var vscroll = self.get_v_scroll_bar()
	vscroll.visible = false
