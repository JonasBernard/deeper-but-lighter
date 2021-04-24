extends Label
class_name TextReveal

signal finished_reveal()

export(String, MULTILINE) var to_render = "Text"
export var speed = 100.0

############
# INTERNAL #
############


var revealed = 0
var started = false
var finished = false
var t = 0

# Called when the node enters the scene tree for the first time.
func _ready():
	theme = preload("res://fonts/Flipps_Theme.tres")
	align = Label.ALIGN_CENTER

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	if not started:
		return
	t += delta * speed
	var additional = int(t)
	t -= additional
	revealed += additional
	text = to_render.substr(0, revealed)
	rect_position = -rect_size / 2
	if to_render.length() == revealed:
		started = false
		finished = true
		emit_signal("finished_reveal")

func start():
	started = true
	text = ""
	revealed = 0
	t = 0
	finished = false


func has_finished():
	return finished
