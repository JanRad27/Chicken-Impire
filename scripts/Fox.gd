extends KinematicBody2D

export(int) var speed = 200
export(NodePath) var hole
var velocity = Vector2.ZERO
var escaping: bool = false

func _ready():
	pass

func _process(delta):
	velocity = Vector2.ZERO
	if escaping:
		velocity.x += speed
	
	move_and_slide(velocity)
		
		

func detected(body):
	if "Chicken" in body.name and not "GigaChicken" in body.name:
		$DetectionArea.disconnect("body_entered", self, "detected")
		$AngryBar.visible = true
		for tick in range(100):
			$AngryBar.value += 1
			yield(get_tree().create_timer(0.1), "timeout")
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
		$AngryBar.value = 0
		$DetectionArea.connect("body_entered", self, "detected")
	elif body.name == "GigaChicken":
		escaping = true
func _undetect(body):
	if "GigaChicken" in body.name:
		yield(get_tree().create_timer(5.0), "timeout")
		escaping = false


