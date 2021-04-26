extends Area2D

class_name Bullet

enum {ORDER, CHAOS}
var velocity = 10
var team = ORDER 

func _process(delta):
	if team == ORDER:
		position.x += velocity
	else:
		position.x -= velocity
