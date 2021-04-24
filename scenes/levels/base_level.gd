extends Node2D

onready var pause_menu = $PauseMenu

# Called when the node enters the scene tree for the first time.
func _ready():
	$Control/TextReveal.start()

func _on_MenuButton_on_click():
	pause_menu.pause()
