extends Level

onready var timer_label = $TimeLabel

var timer = 0
var total = 0

var started = false

func start():
	.start()
	total = _total_time()
	running = true
	$Incorrect.visible = false


func _total_time():
	if Settings.difficulty == Settings.Difficulty.HARD:
		return 30
	return 120
	
func _process(delta):
	if not running:
		return
	if not started:
		return
	timer += delta
	timer_label.text = str(total - timer)
	if timer >= total:
		eval()

func eval():
	if $Label.text.replace('\n', '').replace('\r\n', '').replace('\r', '').replace(' ', '') == $TextEdit.text.replace('\n', '').replace('\r\n', '').replace('\r', '').replace(' ', ''):
		$TextEdit.readonly = true
		$Button.disabled = true
		$Incorrect.visible = false
		finish_level()
	else:
		lose_heart()
		timer = 0
		$TextEdit.text = ""
		$Incorrect.visible = true
		started = false

func eval_corr():
	if $Label.text.replace('\n', '').replace('\r\n', '').replace('\r', '').replace(' ', '') == $TextEdit.text.replace('\n', '').replace('\r\n', '').replace('\r', '').replace(' ', ''):
		$TextEdit.readonly = true
		$Button.disabled = true
		$Incorrect.visible = false
		finish_level()

func _on_Button_on_click():
	eval()


func _on_TextEdit_text_changed():
	if not started:
		started = true
	eval_corr()
