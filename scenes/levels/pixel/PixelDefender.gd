extends Level


const _bullet_scene = preload("res://scenes/levels/pixel/bullet.tscn")
const _enemy_scene = preload("res://scenes/levels/pixel/spaceship.tscn")


func _new_bullet(velocity, team) -> Bullet:
	var bullet = _bullet_scene.instance()
	bullet.velocity = velocity
	bullet.team = team
	$BulletHolder.add_child(bullet)
	return bullet

func _new_enemy():
	var enemy = _enemy_scene.instance()
	enemy.position = Vector2(500 + randi() % 80, (randf() * 600) - 350)
	enemy.scale.x *= -1
	enemy.team = Bullet.CHAOS
	$Enemies.add_child(enemy)
	enemy.connect("area_shape_entered", self, "_on_enemy_area_shape_entered", [enemy])
	return enemy

func start():
	.start()
	t = 0
	$Enemies.get_children().clear()
	var enemy_count = 5
	if Settings.difficulty == Settings.Difficulty.HARD:
		enemy_count += 3
	for i in range(5):
		_new_enemy()

var t = 0
var bullet_timer = 1.5
var enemy_speed = 1

func _process(delta):
	if not running:
		return
	t += delta
	
	while t > bullet_timer:
		t -= bullet_timer
		var b = _new_bullet(10, Bullet.ORDER)
		b.position = $spaceship.position + Vector2(16, 0)
		for e in $Enemies.get_children():
			b = _new_bullet(10, Bullet.CHAOS)
			b.position = e.position - Vector2(16, 0)
	if $Enemies.get_child_count() == 0:
		finish_level()
		return
	for e in $Enemies.get_children():
		e.position -= Vector2(enemy_speed, 0)
		if e.position.x < $spaceship.position.x:
			lose_all_hearts()
			return
	
	$spaceship.position.y = max(0, min(get_viewport().get_mouse_position().y, get_viewport_rect().size.y)) - 360

func _on_enemy_area_shape_entered(area_id, area, area_shape, local_shape, e):
	if area is Bullet and area.team == Bullet.CHAOS:
		return
	if area is Bullet:
		area.queue_free()
	elif area.team == Bullet.CHAOS:
		return
	e.queue_free()

func _on_spaceship_area_shape_entered(area_id, area, area_shape, local_shape):
	if area is Bullet:
		if area.team == Bullet.CHAOS:
			lose_heart()
	else:
		lose_all_hearts()
