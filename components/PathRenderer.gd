extends Node2D

onready var path : Path2D = $Path2D
onready var points  = path.curve.get_baked_points()

func _draw():
	var last_point = 0
	for point in points:
		if last_point is int:
			last_point = point
			continue
		draw_line(last_point, point, Color.brown, 6, false)
		last_point = point
