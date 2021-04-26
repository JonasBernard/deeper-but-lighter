extends Node2D

onready var passwordfield = $password
var trys = 0
var correct = "correct"

func _ready():
	pass # Replace with function body.

func login():
	$Incorrect.visible = false
	get_tree().change_scene("res://scenes/introduction/mail.tscn")

func check_pw():
	if passwordfield.text == correct or Settings.difficulty == Settings.Difficulty.PEACEFUL:
		login()
	else:
		if passwordfield.text == "deeper" or trys == 5:
			$Monolog2.start()
			$Monolog1.visible = false
		if trys == 10:
			$Monolog3.start()
			$Monolog2.visible = false
		if trys == 15:
			$Reset.visible = true
			correct = "tom"
		trys = trys + 1
		$Incorrect.visible = true
		passwordfield.text = ""

func _on_password_text_changed(new_text):
	$Incorrect.visible = false


func _on_password_text_entered(new_text):
	check_pw()

func _on_Log_in_on_click():
	check_pw()
