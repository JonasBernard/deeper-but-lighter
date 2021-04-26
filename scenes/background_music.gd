extends Node

func _on_AudioStreamPlayer_finished():
	$Sound1.play()

func bullet_sound():
	$Bullet.play()

func hover_sound():
	$Hover.play()
	
func click_sound():
	$Click.play()

func type_sound():
	$Type.play()

func lose_heart_sound():
	$LoseHeart.play()
