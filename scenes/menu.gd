extends Node2D


func _ready():
	_difficulty_text()


func _on_Exit_on_click():
	get_tree().quit()


func _on_Strart_on_click():
	if not $Outgoing.is_playing():
		$Outgoing.play("tointro")


func _on_Outgoing_animation_finished(anim_name):
	if anim_name == "tointro":
		get_tree().change_scene("res://scenes/introduction/come home.tscn")


func _on_Back_on_click():
	$success_sound.play(0.5)
	$Outgoing.play_backwards("tosettings")

func _difficulty_text():
	if Settings.difficulty == Settings.Difficulty.HARD:
		$Content/CustomLabel.text = "Hard"
	else:
		$Content/CustomLabel.text = "Easy"

func _on_HardMode_on_click():
	Settings.difficulty = 1 - Settings.difficulty
	_difficulty_text()
	Settings.save()

func _on_SettingsButton_on_click():
	$success_sound.play()
	$Outgoing.play("tosettings")
