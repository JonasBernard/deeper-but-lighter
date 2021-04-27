extends Level

const button = preload("res://components/button.tscn")

var _continue

func _ready():
	_continue = button.instance()
	_continue.position = Vector2(0, 300)
	_continue.visible = false
	_continue.text = "Continue"
	_continue.connect("on_click", self, "cont")
	$TextrevealBox.connect("finished_reveal", self, "show_continue")
	add_child(_continue)

func cont():
	finish_level()

func show_continue():
	_continue.visible = true

func start():
	.start()
	$TextrevealBox.start()
