extends Node

enum Difficulty {EASY, HARD}

var sound_level : int = 100
var difficulty = Difficulty.EASY


##########
# LOADER #
##########

onready var _file = File.new()
const _SETTINGS_PATH = "user://settings.json"

func _save_data():
	return {
		'sound_level': sound_level,
		'difficulty':  difficulty,
	}

func _load_data(json):
	sound_level = json['sound_level']
	difficulty = json['difficulty']

func _load():
	if _file.file_exists(_SETTINGS_PATH):
		return
	_file.open(_SETTINGS_PATH, File.READ)
	var text = _file.get_as_text()
	var json = parse_json(text)
	_load_data(json)
	_file.close()

func save():
	var json = _save_data()
	var text = to_json(json)
	_file.open(_SETTINGS_PATH, File.WRITE)
	_file.store_string(text)
	_file.close()



