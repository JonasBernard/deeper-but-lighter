extends Level



const _button_comp = preload("res://components/button.tscn")

const dim = 4

var parts = []
onready var order = range(dim*dim)

func _ready():
	for i in range(dim*dim-1):
		var button = _button_comp.instance()
		var label = Label.new()
		label.name = "CustomLabel"
		label.text = str(i+1)
		label.rect_size = Vector2(32,32)
		label.rect_position = Vector2(-16,-16)
		label.align = HALIGN_CENTER
		label.valign = VALIGN_CENTER
		button.fixed_width = 30
		button.add_child(label)
		button.connect("on_click", self, "on_anybutton_click", [i+1])
		parts.append(button)
		$Pieces.add_child(button)
	_initial_shuffle(100)
	_render_state()

func _position_from_index(idx):
	return Vector2(idx % dim, int(idx / dim))

func on_anybutton_click(piece_name):
	var pos = _button_position(piece_name)
	_do_push(pos, _hole_position())
	_render_state()
	_check_state()

func _render_state():
	for i in range(dim*dim):
		if order[i] == 0:
			continue
		var piece = parts[order[i]-1]
		piece.position = _position_from_index(i) * 80

func _check_state():
	for i in range(dim*dim):
		if order[i] != i:
			return
	finish_level()


func _hole_position():
	return _button_position(0)

func _button_position(piece_name):
	for i in range(dim*dim):
		if order[i] == piece_name:
			return i
	push_error("No "+str(piece_name)+" present")
	assert(false)

func _do_push(from, to):
	if to == from:
		return
	var same_row = int(to / dim) == int(from/dim)
	var same_col = int(to % dim) == int(from % dim)
	var dir = sign(from - to)
	if not (same_row or same_col):
		print("Invalid move")
		return
	print("Performing push from ", from, " to ", to, " in direction ", dir)
	var i = to
	while i != from:
		var next_pos
		if same_row:
			next_pos = i + 1 * dir
		else:
			next_pos = i + dim * dir
		order[i] = order[next_pos]
		i = next_pos
	order[from] = 0
	
func _initial_shuffle(it):
	var hp = _hole_position()
	for i in range(it):
		var dir 
		var p = _position_from_index(hp)
		if randi() % 2 ==0:
			var m = range(p.x+1, dim)
			m.append_array(range(p.x))
			m.shuffle()
			dir = m[0] - p.x
		else:
			var m = range(p.y+1, dim)
			m.append_array(range(p.y))
			m.shuffle()
			dir = (m[0]-p.y)* dim
		_do_push(int(hp + dir), hp)
		hp = int(hp+dir)
