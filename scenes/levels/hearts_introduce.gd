extends Level

func start():
	.start()
	$Label.visible = true
	$Sprite.visible = true
	yield(get_tree().create_timer(2.0), "timeout")
	finish_level()
