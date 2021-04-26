extends Node2D

class_name Level
signal lost_heart(instakill)
signal level_finished()

var running = false

func start():
	print("Level ", name, " starting.")
	running = true

func lose_heart():
	BackgroundMusic.lose_heart_sound()
	emit_signal("lost_heart", false)

func lose_all_hearts():
	BackgroundMusic.lose_heart_sound()
	emit_signal("lost_heart", true)

func finish_level():
	running = false
	emit_signal("level_finished")

