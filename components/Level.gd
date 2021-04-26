extends Node2D

class_name Level
signal lost_heart(instakill)
signal level_finished()


func start():
	print("Level ", name, " starting.")

func lose_heart():
	emit_signal("lost_heart", false)

func lose_all_hearts():
	emit_signal("lost_heart", true)

func finish_level():
	emit_signal("level_finished")

