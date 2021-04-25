extends Level

export(String, MULTILINE) var text = ""

signal next()

# Called when the node enters the scene tree for the first time.
func _ready():
	$Continue.visible = false
	$TextReveal.to_render = text
	$TextReveal.start()

func _on_TextReveal_finished_reveal():
	$Continue.visible = true
	$Skip.visible = false

func _next():
	emit_signal("next")

func _on_Button_on_click():
	_next()

func _on_Skip_on_click():
	_next()
