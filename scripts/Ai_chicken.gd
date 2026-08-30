extends KinematicBody2D

export(int) var chicken_id = 0
onready var my_data = null
var bug_in_vision = {"on":false, "data":null}

var speed = 120 # Скорость плавного бега объекта
var target_position = Vector2(global_position) 
var eat_need_for_one = 50
var is_died: bool = false

func _ready():
	var eating_timer = Timer.new()
	eating_timer.wait_time = 3.0
	eating_timer.autostart = true
	add_child(eating_timer)	
	
	eating_timer.connect("timeout", self, "eat_grass")
	
func eat_grass():
	if my_data["satiety"] > 0 and not is_died:
		$Sprite.texture = preload("res://images/Chicken-Eating-Grass.png")
		yield(get_tree().create_timer(1.0), "timeout")
		$Sprite.texture = preload("res://images/Chicken.png")
func _process(delta):
	if is_died:
		return
	for chicken in Global.chickens.values():
		if chicken["id"] == chicken_id:
			my_data = chicken
			break
		else:
			continue
	if my_data == null:
		print("Chicken with identifier " + str(chicken_id) + " not exists")
		get_tree().quit()
	$Satiety_bar.value = my_data["satiety"]
	if bug_in_vision["on"] and my_data["satiety"] < 70 and my_data["satiety"] > 0:
		var bug = bug_in_vision["data"]
		if global_position.distance_to(bug.get_node("CollisionShape2D").global_position) > 10:
			target_position = bug.global_position
		

func body_entered_vision_area(body):
	if is_died:
		return
	if body.name.begins_with("Bug_Corn") or body.name.begins_with("Bug_Wheat") or body.name.begins_with("Bug_Compound_Food"):
		bug_in_vision = {"on":true, "data":body}
func body_outed_vision_area(body):
	if is_died:
		return
	if body.name.begins_with("Bug_Corn") or body.name.begins_with("Bug_Wheat") or body.name.begins_with("Bug_Compound_Food"):
		bug_in_vision = {"on":false, "data":body}
func eat_bug_eat(body):
	if body.name.begins_with("Bug_Corn") or body.name.begins_with("Bug_Wheat") or body.name.begins_with("Bug_Compound_Food") and not is_died:
		var eat_need_p = 100 - my_data["satiety"]
		var eat_need_g = eat_need_p * eat_need_for_one
		eat_need_g = eat_need_g / body.eat_satiety
		if eat_need_g / 1000.0 <= body.eat_count_kg:
			Global.chickens[chicken_id]["satiety"] += eat_need_p
			body.eat_count_kg -= eat_need_g / 1000.0

func _physics_process(delta):
	# Проверяем расстояние: если мы уже близко к цели (ближе 5 пикселей), то стоим на месте
	if global_position.distance_to(target_position) > 5:
		# 1. Находим направление и 2. Нормализуем его
		var direction = (target_position - global_position).normalized()
		
		# 3. Рассчитываем скорость и плавно двигаем тело!
		var velocity = direction * speed
		move_and_slide(velocity)
func kill():
	is_died = true
	$Sprite.texture = load("res://images/died_chicken.png")
	yield(get_tree().create_timer(5.0), "timeout")
	Global.chickens.erase(my_data)
	queue_free()
	
	
