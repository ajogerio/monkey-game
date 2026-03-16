extends Node2D

@onready var fun_track: AudioStreamPlayer = $"Fun Track"
@onready var intense_track: AudioStreamPlayer = $"Intense Track"

func play_track(track_name: String):
	stop_all()
	match track_name:
		"Fun Track":
			fun_track.play()
		"Intense Track":
			intense_track.play()

func stop_all():
	fun_track.stop()
	intense_track.stop()
