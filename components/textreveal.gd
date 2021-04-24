extends Node2D

onready var font_source : RichTextLabel = $FontSource
signal finished_reveal()

export var text = "Text"
export var speed = 100.0

var revealed = 0
var started = false
var finished = false

var label

# Called when the node enters the scene tree for the first time.
func _ready():
	label = RichTextLabel.new()
	label.theme = font_source.theme
	add_child(label)
	label.rect_position = -label.rect_size / 2


func _show_text(text):
	label.add_text(text)
	label.rect_position = -label.rect_size / 2

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	if started:
		var reveal = speed * delta
		var oldreveal = revealed
		revealed += reveal
		var t = text.substr(oldreveal, revealed)
		_show_text(t)
		if text.length() <= revealed:
			started = false
			finished = true
			emit_signal("finished_reveal")

func start():
	started = true
	finished = false


func has_finished():
	return finished
