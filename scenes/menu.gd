extends Node2D


func _ready():
	pass


func _on_Exit_on_click():
	get_tree().quit()


func _on_Strart_on_click():
	if not $Outgoing.is_playing():
		$Outgoing.play("tointro")


func _on_Outgoing_animation_finished(anim_name):
	get_tree().change_scene("res://scenes/introduction.tscn")
