extends Level

onready var timer_label = $TimeLabel

var timer = 0
var total = 0

func start():
	.start()
	total = _total_time()
	running = true
	$Incorrect.visible = false


func _total_time():
	if Settings.difficulty == Settings.Difficulty.HARD:
		return 10
	return 20
	
func _process(delta):
	if not running:
		return
	timer += delta
	timer_label.text = str(total - timer)
	if timer >= total:
		eval()

func eval():
	if $Label.text.replace('\r\n', '\n').replace('\r', '\n') == $TextEdit.text.replace('\r\n', '\n').replace('\r', '\n'):
		finish_level()
	else:
		lose_heart()
		timer = 0
		$TextEdit.text = ""
		$Incorrect.visible = true

func _on_Button_on_click():
	eval()
