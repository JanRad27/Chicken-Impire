extends KinematicBody2D

export(int) var speed = 200
export(NodePath) var hole
var velocity = Vector2.ZERO
var escaping: bool = false
var hole_node: StaticBody2D
var target: Vector2

func _ready():
	hole_node = get_node(hole)
	Debug.add_log("Fox spawned!")

func _process(delta):
	if int(Global.game_time.get_time_array()[2]) > 7:
		Debug.add_log("Fox exited: Morning starts!")
		queue_free()
	velocity = Vector2.ZERO
	if escaping:
		target = hole_node.global_position	
	else:
		Debug.add_log("Fox is hungry! Fox started run to chickens!")
		target = Vector2(0, 100)
	if global_position.distance_to(target) <= 10:
		target = Vector2.ZERO
	if not target == Vector2.ZERO:
		var direction = (target - global_position).normalized()
		velocity = direction * speed
	move_and_slide(velocity)
		
		

func detected(body):
	if "Chicken" in body.name and not "GigaChicken" in body.name and not escaping:
		target = Vector2.ZERO
		Debug.add_log("Fox detected chicken in vision radius!")
		$DetectionArea.disconnect("body_entered", self, "detected")
		$AngryBar.visible = true
		for tick in range(100):
			$AngryBar.value += 1
			yield(get_tree().create_timer(0.1), "timeout")
		Debug.add_log("Fox angryed!")
		var chicken_width = body.get_node("Sprite").texture.get_size().x
		var my_width = $Sprite.texture.get_size().x
		var stop_distance = (chicken_width / 2) + (my_width / 2)
		
		# Мягко прижимаем Лису к Курице ровно на одной высоте!
		global_position = Vector2(body.global_position.x - stop_distance, body.global_position.y)
		
		# НАМЕРТВО СБРАСЫВАЕМ ВЕСЬ ВЕКТОР СКОРОСТИ! Полный стоп по X и Y!
		velocity = Vector2.ZERO
		
		move_and_slide(velocity)
		
		# Запускаем твой асинхронный yield-таймер kill() в скрипте Курицы!
		if body.has_method("kill"):
			body.kill()
		Debug.add_log("Fox killed chicken!")
		$AngryBar.value = 0
		$DetectionArea.connect("body_entered", self, "detected")
	elif body.name == "GigaChicken":
		escaping = true
		Debug.add_log("Fox detected GigaChicken and started escaping!")
func _undetect(body):
	if "GigaChicken" in body.name:
		Debug.add_log("Fox no longer vision GigaChicken!")
		yield(get_tree().create_timer(5.0), "timeout")
		escaping = false
		Debug.add_log("Fox stoped escaping!")


