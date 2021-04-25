extends Node2D

class_name Level
signal lost_heart()
signal level_finished()


func start():
	print("Level starting.")

func lose_heart():
	emit_signal("lost_heart")

func finish_level():
	emit_signal("level_finished")

