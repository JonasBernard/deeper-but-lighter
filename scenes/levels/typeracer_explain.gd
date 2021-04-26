extends Level

func start():
	.start()
	$TextrevealBox.start()


func _on_TextrevealBox_finished_reveal():
	finish_level()
