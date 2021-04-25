extends Node2D

func _on_CanvasLayer_next():
	get_tree().change_scene("res://scenes/introduction/check_mail.tscn")
