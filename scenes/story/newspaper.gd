extends Level


func cont():
	get_tree().change_scene("res://scenes/menu.tscn")


func _on_Button_on_click():
	cont()
