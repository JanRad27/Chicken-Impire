extends KinematicBody2D

var security_scene = preload("res://scenes/GigaChicken.tscn")
var security
var bug_in_vision = {"on":false, "data":null}
export(int) var chicken_id
var my_data
var target_position
var speed = 150
const is_died = true
const eat_need_for_one = 400
# Declare member variables here. Examples:
# var a = 2
# var b = "text"


# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	for chicken in Global.chickens:
		if chicken["id"] == chicken_id:
			my_data = chicken
			break
		else:
			continue
	if my_data == null:
		print("Chicken with identifier " + str(chicken_id) + " not exists")
		get_tree().quit()
	if bug_in_vision["on"] and my_data["satiety"] < 70 and my_data["satiety"] > 0:
		var bug = bug_in_vision["data"]
		if global_position.distance_to(bug.get_node("CollisionShape2D").global_position) > 10:
			target_position = bug.global_position
	

func _physics_process(delta):
	# Проверяем расстояние: если мы уже близко к цели (ближе 5 пикселей), то стоим на месте
	if target_position and global_position.distance_to(target_position) > 5:
		# 1. Находим направление и 2. Нормализуем его
		var direction = (target_position - global_position).normalized()
		
		# 3. Рассчитываем скорость и плавно двигаем тело!
		var velocity = direction * speed
		move_and_slide(velocity)


func _detect(body):
	if "Fox" in body.name:
		if security:
			return
		security = security_scene.instance()
		add_child(security)
		security.global_position = global_position
		security.base_position = global_position
		
		security.move_and_slide(Vector2.ZERO) # Выталкиваем этого Цыпу-Гигачада из себя!
	elif body.name.begins_with("Bug_Corn") or body.name.begins_with("Bug_Wheat") or body.name.begins_with("Bug_Compound_Food"):
		bug_in_vision = {"on":true, "data":body}
		
func _undetect(body):
	if "Fox" in body.name:
		remove_child(security)
		security = null
	elif body.name.begins_with("Bug_Corn") or body.name.begins_with("Bug_Wheat") or body.name.begins_with("Bug_Compound_Food"):
		bug_in_vision = {"on":false, "data":null}
		


func eat_bug_eat(body):
	if body.name.begins_with("Bug_Compound_Food") and not is_died:
		if "k1" in body.name:
			Global.currently_price_boost += 0.1
		elif "k2" in body.name:
			Global.currently_price_boost += 0.05
		elif "k3" in body.name:
			Global.currently_price_boost += 0.01
		var eat_need_p = 100 - my_data["satiety"]
		var eat_need_g = eat_need_p * eat_need_for_one
		eat_need_g = eat_need_g / body.eat_satiety
		if eat_need_g / 1000.0 <= body.eat_count_kg:
			Global.chickens[chicken_id]["satiety"] += eat_need_p
			body.eat_count_kg -= eat_need_g / 1000.0
