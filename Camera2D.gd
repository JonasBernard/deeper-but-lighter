extends Camera2D


# Declare member variables here. Examples:
# var a = 2
# var b = "text"

onready var path : Path2D = get_node(@"../Path2D")
onready var points = path.curve.get_baked_points()
export var max_speed = 10

var pidx = 0
# Called when the node enters the scene tree for the first time.
func _ready():
	pass

func current_speed():
	return max_speed

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	if pidx == -1:
		return
	var next_point = points[pidx]
	var dist : Vector2 = next_point - position
	print(dist.length(),"\t", current_speed() * delta)
	if dist.length() - current_speed() * delta < 0.5:
		position = next_point
		pidx += 1
		if pidx >= points.size():
			pidx = -1
		return
	var velocity = dist.normalized() * current_speed() * delta
	position += velocity
	

