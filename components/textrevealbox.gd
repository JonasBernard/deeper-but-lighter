extends Node2D

export(String, MULTILINE) var text = "Failed to load text :("
export var autostart = true
export var speed = 10

signal finished_reveal()

func _ready():
	$TextReveal.to_render = text
	$TextReveal.speed = speed
	if autostart:
		$TextReveal.start()

func start():
	$TextReveal.start()


func _on_TextReveal_finished_reveal():
	emit_signal("finished_reveal")
