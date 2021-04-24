extends Node2D

export var maxhealth = 3
export var offset = 40

var h: PackedScene = preload("res://components/healthbar/heart.tscn")
var hearts: Array = []



# Called when the node enters the scene tree for the first time.
func _ready():
	for i in maxhealth:
		var heart = h.instance()
		hearts.append(heart)
		heart.position = Vector2(i * offset, 0)
		heart.scale = Vector2(3,3)
		add_child(heart)
		

func _process(delta):
	pass
	
func set_health(health: int=maxhealth):
	for i in maxhealth:
		hearts[i].set_filled(i < health)
