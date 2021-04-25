extends Node2D

class_name PathRenderer

export var path_color : Color = Color.brown setget _color
export var stroke_width : int = 6 setget _width
var path : Path2D = null setget _path

func _width(value):
	stroke_width = value
	update()

func _color(value):
	path_color = value
	update()

func _path(value):
	path = value
	update()

func _draw():
	if path == null:
		return
	var last_point = null
	var points = path.curve.get_baked_points()
	for point in points:
		if last_point == null:
			last_point = point
			continue
		draw_line(last_point, point, path_color, stroke_width, false)
		last_point = point
