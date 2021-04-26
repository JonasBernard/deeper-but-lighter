extends CanvasLayer

onready var pause_menu = $Node2D

signal unpause()

func pause():
	pause_mode = PAUSE_MODE_PROCESS # to be save
	pause_menu.visible = true
	get_tree().paused = true

func _on_Resume_on_click():
	pause_menu.visible = false
	get_tree().paused = false
	emit_signal("unpause")


func _on_Main_Menu_on_click():
	get_tree().paused = false
	get_tree().change_scene("res://scenes/menu.tscn")
