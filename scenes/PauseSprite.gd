extends ColorRect

func _input(event):
	for c in get_parent().get_children():
		if c != self:
			c._notifaction(c.NOTIFICATION_INPUT)
