extends Node2D

class_name Level
signal lost_heart()
signal level_finished()

onready var passwordfield = $password
var trys = 0


func start():
	print("Level starting.")

func lose_heart():
	emit_signal("lost_heart")

func finish_level():
	emit_signal("level_finished")

func login():
	$Incorrect.visible = false
	get_tree().change_scene("res://scenes/introduction/mail.tscn")
	finish_level()
	
func check_pw():
	if passwordfield.text == "correct":
		login()
	else:
		if passwordfield.text == "deeper" or trys == 10:
			$Monolog2.start()
			$Monolog1.visible = false
		if trys == 20:
			$Monolog3.start()
			$Monolog2.visible = false
		trys = trys + 1
		$Incorrect.visible = true
		passwordfield.text = ""

func _on_Button_on_click():
	check_pw()


func _on_password_text_changed(new_text):
	$Incorrect.visible = false


func _on_password_text_entered(new_text):
	check_pw()
