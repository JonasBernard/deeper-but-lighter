extends Node2D
class_name ButtonTest
export var text = "Hello, Button"
onready var stretcher : Node2D = $Middle
onready var left : Node2D = $Left
onready var right : Node2D = $Right
onready var font_source : RichTextLabel = $FontSource
const BASE_WIDTH = 6

func _ready():
	var label = Label.new()
	label.text = text
	label.theme = font_source.theme
	add_child(label)
	label.rect_position = -label.rect_size / 2
	var width = label.rect_size.x
	stretcher.scale.x = width / BASE_WIDTH
	left.position.x = -label.rect_size.x / 2 - BASE_WIDTH
	right.position.x = label.rect_size.x / 2

