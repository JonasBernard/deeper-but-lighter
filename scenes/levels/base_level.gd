extends Node2D

onready var _pause_menu = $Camera2D/PauseMenu
onready var _level_holder = $LevelHolder
onready var _camera : CameraTrackFollower = $Camera2D
onready var _path_renderer : PathRenderer = $PathRenderer
onready var _health_bar = $Camera2D/healthbar
onready var _last_camera_location : Vector2 = $Camera2D.position
const _levels = [
	preload("res://scenes/introduction.tscn")
]

var _current_level = 0
var _loaded_level : Level
var _track : Path2D
var _health = 10

# Called when the node enters the scene tree for the first time.
func _ready():
	_health_bar.maxhealth = 10
	_load_current_level()

func _get_next_level_pos() -> Vector2:
	var dir = (randi() % 2) * 2 -1
	return _last_camera_location + Vector2(500, dir * (500 + randi() % 500))

func _create_path_from(from: Vector2, to: Vector2):
	var path = Path2D.new()
	var curve = Curve2D.new()
	var diff = to -from
	curve.add_point(from)
	curve.add_point(from + Vector2(diff.x, 0))
	curve.add_point(to)
	path.curve = curve
	return path

func _add_hooks():
	_loaded_level.connect("level_finished", self, "_on_Level_level_finished")
	_loaded_level.connect("lost_heart", self, "_on_Level_lost_heart")

func _on_Level_level_finished():
	pass # TODO

func _on_Level_lost_heart():
	_health -= 1
	if _health == 0:
		pass # TODO: lose scenario
	_health_bar.set_health(_health)

func _load_current_level():
	if _loaded_level != null:
		push_error("Tried to load level, while another level was already loaded.")
		assert(false)
	var pos = _get_next_level_pos()
	print("Loading level at ",pos)
	_loaded_level = _levels[_current_level].instance()
	_loaded_level.position = pos
	_add_hooks()
	_level_holder.add_child(_loaded_level)
	print("Level loaded")
	_track = _create_path_from(_last_camera_location, pos)
	add_child(_track)
	print("Tracks loaded")
	_path_renderer.path = _track
	_camera.path = _track

func _on_MenuButton_on_click():
	_pause_menu.pause()


func _on_Camera2D_done():
	print("Camera movement done")
	_loaded_level.start()
