extends KinematicBody2D

var right_texture = preload("res://Farmer.png")
var left_texture = preload("res://Farmer-left.png")

# Твоя новая прокачанная скорость бега фермера!
var speed = 200 
var velocity = Vector2.ZERO # Вектор направления движения

# Эта встроенная функция работает каждый физический кадр игры без единого лага!
func _physics_process(delta):
	velocity = Vector2.ZERO # Обнуляем движение каждый кадр, чтобы персонаж не улетал сам
	if Global.player_may_move:
		# Считываем зажатие клавиш прямо из системы
		if Input.is_action_pressed("move-right"):
			$Sprite.texture = right_texture
			velocity.x += 1
		if Input.is_action_pressed("move-left"):
			$Sprite.texture = left_texture
			velocity.x -= 1
		if Input.is_action_pressed("move-down"):
			 velocity.y += 1
		if Input.is_action_pressed("move-up"):
			velocity.y -= 1
			
		# Нормализуем вектор (чтобы фермер не бегал по диагонали в два раза быстрее!)
		if velocity.length() > 0:
			velocity = velocity.normalized() * speed
			
		# Бронебойная физическая команда Godot — двигает фермера и обсчитывает столкновения!
		velocity = move_and_slide(velocity)

