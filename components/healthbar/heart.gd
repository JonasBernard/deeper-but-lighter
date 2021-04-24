extends Node2D


onready var fill = $fill
onready var notfill = $notfill

# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.


func _process(delta):
	pass
	
func set_filled(filled: bool):
	if filled:
		fill.visible = true
		notfill.visible = false
	else:
		notfill.visible = true
		fill.visible = false
	
