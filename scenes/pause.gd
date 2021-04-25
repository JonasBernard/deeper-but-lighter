extends Node2D

onready var pause_menu = $"."
onready var backgroud = $Sprite

func pause():
	pause_menu.visible = true
	pause_menu.pause_mode = PAUSE_MODE_PROCESS # to be save
	# get_tree().paused = true


func _ready():
	backgroud.modulate.a = 0.5


func _on_Resume_on_click():
	pause_menu.visible = false
	# get_tree().paused = false


func _on_Main_Menu_on_click():
	get_tree().change_scene("res://scenes/menu.tscn")
