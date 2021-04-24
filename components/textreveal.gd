extends Node2D

signal finished_reveal()

export(String, MULTILINE) var text = "Text"
export var speed = 100.0

############
# INTERNAL #
############


onready var font_source : RichTextLabel = $FontSource
var revealed = 0
var started = false
var finished = false
var t = 0
onready var label = Label.new()

# Called when the node enters the scene tree for the first time.
func _ready():
	label.theme = font_source.theme
	label.align = Label.ALIGN_CENTER
	add_child(label)


func _show_text(text):
	label.text = text
	label.rect_position = -label.rect_size / 2

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	if not started:
		return
	t += delta * speed
	var additional = int(t)
	t -= additional
	revealed += additional
	_show_text(text.substr(0, revealed))
	if text.length() == revealed:
		started = false
		finished = true
		emit_signal("finished_reveal")

func start():
	started = true
	label.text = ""
	revealed = 0
	t = 0
	finished = false


func has_finished():
	return finished
