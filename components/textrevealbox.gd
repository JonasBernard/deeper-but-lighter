extends Node2D

export(String, MULTILINE) var text = "Failed to load text :("
export var autostart = true

func _ready():
	$TextReveal.to_render = text
	if autostart:
		$TextReveal.start()

func start():
	$TextReveal.start()
