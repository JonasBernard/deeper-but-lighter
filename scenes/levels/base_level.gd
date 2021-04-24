extends Node2D

onready var pause_menu = $PauseMenu

# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta):
#	pass

func _on_MenuButton_on_click():
	pause_menu.visible = true
	pause_menu.pause()
