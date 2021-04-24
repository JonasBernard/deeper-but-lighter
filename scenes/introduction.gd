extends Node

onready var textreveal = $Textreveal

# Called when the node enters the scene tree for the first time.
func _ready():
	textreveal.start()


func _on_Textreveal_finished_reveal():
	print("Done")
