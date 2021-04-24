extends Node2D

onready var pause_menu = $"."

func pause():
	pause_menu.pause_mode = PAUSE_MODE_PROCESS
	get_tree().paused = true

