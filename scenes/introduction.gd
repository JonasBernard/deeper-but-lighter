extends Node


# Called when the node enters the scene tree for the first time.
func _ready():
	$Continue.visible = false
	$TextReveal.start()



func _on_TextReveal_finished_reveal():
	$Continue.visible = true



func _on_Button_on_click():
	get_tree().change_scene("res://scenes/levels/base_level.tscn")


func _on_Skip_on_click():
	get_tree().change_scene("res://scenes/levels/base_level.tscn")
