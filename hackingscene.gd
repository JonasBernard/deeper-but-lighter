extends Node2D


var button_presses = 0


func _on_HackButton_on_click():
	button_presses += 1
	print(button_presses)
