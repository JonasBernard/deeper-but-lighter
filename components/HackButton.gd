extends Area2D

signal on_click()

var is_hovered = false

onready var sprite : Sprite = $Sprite
export(String, FILE, '*.png') var hovered_texture = "res://textures/blauuu.png"
onready var _hovered_texture : Texture = load(hovered_texture)
onready var _default_texture : Texture = sprite.texture

func _on_HackButton_mouse_entered():
	is_hovered = true
	sprite.texture = _hovered_texture

func _on_HackButton_mouse_exited():
	is_hovered = false
	sprite.texture = _default_texture


func _on_HackButton_input_event(viewport, event, shape_idx):
	if not (event is InputEventMouseButton):
		return
	if not event.pressed:
		return
	emit_signal("on_click")

