extends Node2D
class_name ButtonTest
export var text = "Hello, Button"
# Force a fixed width if != -1
export var fixed_width = -1
signal on_click()
var is_hovered = false



#############
# INTERNALS #
#############

onready var stretcher : Node2D = $Middle
onready var left : Node2D = $Left
onready var right : Node2D = $Right
onready var font_source : RichTextLabel = $FontSource
onready var hitbox : CollisionShape2D = $Hitbox
const BASE_WIDTH = 6
const BASE_HEIGHT = 16

const left_nohover = preload("res://textures/components/button/left.png")
const left_hover = preload("res://textures/components/button/left_hover.png")
const middle_nohover = preload("res://textures/components/button/middle.png")
const middle_hover = preload("res://textures/components/button/middle_hover.png")
const right_nohover = preload("res://textures/components/button/right.png")
const right_hover = preload("res://textures/components/button/right_hover.png")

func _ready():
	var label = Label.new()
	label.text = text
	label.theme = font_source.theme
	add_child(label)
	label.rect_position = -label.rect_size / 2
	var width = label.rect_size.x
	if fixed_width > 0:
		width = fixed_width
	stretcher.scale.x = width / BASE_WIDTH
	left.position.x = -width / 2 - BASE_WIDTH
	right.position.x = width / 2 + BASE_WIDTH
	hitbox.shape.extents.x = width / 2 + BASE_WIDTH * 3



func _on_ButtonTest_input_event(viewport, event, shape_idx):
	if not (event is InputEventMouseButton):
		return
	if not event.pressed:
		return
	emit_signal("on_click")
	
func _set_all_textures(l, m, r):
	left.texture = l
	stretcher.texture = m
	right.texture = r

func _on_ButtonTest_mouse_entered():
	if not is_hovered:
		_set_all_textures(left_hover, middle_hover, right_hover)
	is_hovered = true


func _on_ButtonTest_mouse_exited():
	if is_hovered:
		_set_all_textures(left_nohover, middle_nohover, right_nohover)
	is_hovered = false
