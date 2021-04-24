extends Node

onready var textreveal = $TextReveal

# Called when the node enters the scene tree for the first time.
func _ready():
	textreveal.start()

