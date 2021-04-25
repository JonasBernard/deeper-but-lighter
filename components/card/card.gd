extends Sprite
class_name Card

export var width = 100
export var height = 50 

onready var color = preload("res://textures/colors/light_blue.png")

var card

# Called when the node enters the scene tree for the first time.
func _ready():
	card = Sprite.new()
	card.scale = Vector2(width, height)
	card.texture = color
	add_child(card)


# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta):
#	pass
