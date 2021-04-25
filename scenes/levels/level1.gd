extends Level

onready var buttons = $ButtonHolder.get_children()

var order = [
	9, 8, 7, 6, 5, 4, 3, 2, 1, 0
]
var sequence_index = 0

func _ready():
	for i in range(buttons.size()):
		buttons[i].connect("on_click", self, "_on_AnyButton_click", [i])

func _on_Any_button_click(btn_idx):
	if btn_idx == order[sequence_index]:
		sequence_index += 1
		print("Correct button: ", btn_idx)
	else:
		print("Incorrect button: ", btn_idx)
