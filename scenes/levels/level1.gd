extends Level

onready var buttons = $ButtonHolder.get_children()

var sequence_index = 0

func _ready():
	for i in range(buttons.size()):
		buttons[i].connect("on_click", self, "_on_Any_button_click", [i])
		buttons[i].text = str(i + 1)
		if i != 0:
			buttons[i].visible = false

func _on_Any_button_click(btn_idx):
	if btn_idx == sequence_index:
		sequence_index += 1
		if sequence_index == buttons.size():
			finish_level()
		buttons[sequence_index].visible = true
		print("Correct button: ", btn_idx)
	else:
		lose_heart()
		print("Incorrect button: ", btn_idx)
