extends Node2D

onready var pause_menu = $Camera2D/PauseMenu

# Called when the node enters the scene tree for the first time.
func _ready():
	$Control/TextReveal.start()
	$Camera2D/healthbar.set_health(2)

func _on_MenuButton_on_click():
	pause_menu.pause()
