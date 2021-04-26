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
	return 60
	
func _process(delta):
	if not running:
		return
	timer += delta
	timer_label.text = str(total - timer)
	if timer >= total:
		eval()

func eval():
	if $Label.text.replace('\r\n', '\n').replace('\r', '\n') == $TextEdit.text.replace('\r\n', '\n').replace('\r', '\n'):
		$TextEdit.readonly = true
		finish_level()
	else:
		lose_heart()
		timer = 0
		$TextEdit.text = ""
		$Incorrect.visible = true

func eval_corr():
	if $Label.text.replace('\r\n', '\n').replace('\r', '\n') == $TextEdit.text.replace('\r\n', '\n').replace('\r', '\n'):
		$TextEdit.readonly = true
		finish_level()

func _on_Button_on_click():
	eval()


func _on_TextEdit_text_changed():
	eval_corr()
