extends Label
class_name TextReveal

signal finished_reveal()

export(String, MULTILINE) var to_render = "Text"
export var speed = 20.0

export var xpos = 0
export var ypos = 0

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
	rect_position = Vector2(xpos, ypos)

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	if not started:
		return
	t += delta * speed
	if t < 0:
		return
	var additional = int(t)
	t -= additional
	revealed += additional
	if additional >= 1:
		BackgroundMusic.type_sound()
	text = to_render.substr(0, revealed)
	if additional > 0:
		if text.ends_with("\n"):
			t = -7
		if text.ends_with(" "):
			t += 1
	rect_position = -rect_size / 2 + Vector2(xpos, ypos)
	if to_render.length() <= revealed:
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
