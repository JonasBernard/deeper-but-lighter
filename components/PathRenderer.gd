extends Node2D

class_name PathRenderer

export var path_color : Color = Color.brown setget _color
export var target_color : Color = Color.red setget _target_color
export var stroke_width : int = 6 setget _width
var path : Path2D = null setget _path

func _width(value):
	stroke_width = value
	update()

func _color(value):
	path_color = value
	update()

func _target_color(value):
	target_color = value
	update()

func _path(value):
	path = value
	update()

func _draw():
	if path == null:
		return
	var last_point = null
	var points = path.curve.get_baked_points()
	var length = path.curve.get_baked_length()
	var dist = 0
	for point in points:
		if last_point == null:
			last_point = point
			continue
		dist += (last_point - point).length()
		var col = lerp(path_color, target_color, dist / length)
		draw_line(last_point, point, col, stroke_width, false)
		last_point = point
