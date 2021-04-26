extends Camera2D
class_name CameraTrackFollower
var path : Path2D setget _path

signal done()

var _points
func _path(value):
	path = value
	if path == null:
		_points = []
		_pidx = -1
	else:
		_pidx = 0
		_t = 0
		_points = value.curve.get_baked_points()
	current_speed = 0
	_done_emitted = false
	print("New path set to CameraTrackFollower")
export var speedup = 100
export var speedup_time = 5
export var initial_speed = 100
var current_speed = initial_speed
var _pidx = -1
var _done_emitted = true
var _t = 0

func _process(delta):
	if _pidx == -1:
		if not _done_emitted:
			emit_signal("done")
			_done_emitted = true
		return
	var next_point = _points[_pidx]
	var dist : Vector2 = next_point - position
	if _t < speedup_time:
		current_speed += speedup * max(0, min(speedup_time-_t, delta))
		_t += delta
	if dist.length() - current_speed * delta < 0.5:
		position = next_point
		_pidx += 1
		if _pidx >= _points.size():
			_pidx = -1
		_process(delta - dist.length() / current_speed)
		return
	var velocity = dist.normalized() * current_speed * delta
	position += velocity

