extends Node2D

onready var _pause_menu = $Camera2D/PauseMenu
onready var _level_holder = $LevelHolder
onready var _camera : CameraTrackFollower = $Camera2D
onready var _path_renderer : PathRenderer = $PathRenderer
onready var _health_bar = $Camera2D/healthbar
onready var _last_camera_location : Vector2 = $Camera2D.position
const _levels = [
	preload("res://scenes/levels/hearts_introduce.tscn"),
	preload("res://scenes/levels/typeracer_explain.tscn"),
	preload("res://scenes/levels/typeracer.tscn"),
	preload("res://scenes/levels/reactiontest.tscn"),
	preload("res://scenes/levels/pixel/PixelDefender.tscn"),
	preload("res://scenes/levels/puzzle/puzzle.tscn"),
]

var _current_level = 0
var _loaded_level : Level
var _track : Path2D
var _health = 10
var first_level = true

# Called when the node enters the scene tree for the first time.
func _ready():
	_health_bar.set_health(10)
	_load_current_level()

func _get_next_level_pos() -> Vector2:
	var dir = (randi() % 2) * 2 -1
	return _last_camera_location + Vector2(1000, dir * (1000 + randi() % 1000))

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
	_load_next_level()

func _on_Level_lost_heart(instakill):
	if instakill:
		_health = 0
	_health -= 1
	if _health <= 0:
		get_tree().change_scene("res://scenes/game_over.tscn")
	_health_bar.set_health(_health)

func _load_next_level():
	_unload_current_level()
	_current_level += 1
	if _current_level >= _levels.size():
		get_tree().change_scene("res://scenes/menu.tscn")
		return
	_load_current_level()

func _unload_current_level():
	_loaded_level = null
	for c in _level_holder.get_children():
		_delayed_delete(c)
	if _track:
		_track.queue_free()
	yield(get_tree(), "idle_frame") # todo animation here? post mortem

func _delayed_delete(c):
	yield(get_tree().create_timer(5.0), "timeout")
	c.queue_free()
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
	if not first_level:
		_track = _create_path_from(_last_camera_location, pos)
		add_child(_track)
		print("Tracks loaded")
		_path_renderer.path = _track
		_camera.path = _track
	else:
		first_level = false
		_camera.path = null
		_camera.position = pos
		_on_Camera2D_done()

func _on_MenuButton_on_click():
	_disable_input(_level_holder)
	_pause_menu.pause()


func _on_Camera2D_done():
	print("Camera movement done")
	_last_camera_location = _camera.position
	_loaded_level.start()

func _disable_input(node):
	# this is barbaric
	if node is Control:
		node.mouse_filter = Control.MOUSE_FILTER_IGNORE
	for n in node.get_children():
		_disable_input(n)

func _enable_input(node):
	if node is Control:
		node.mouse_filter = Control.MOUSE_FILTER_STOP
	for n in node.get_children():
		_enable_input(n)

func _on_PauseMenu_unpause():
	_enable_input(_level_holder)
	_level_holder.set_process_input(true)
