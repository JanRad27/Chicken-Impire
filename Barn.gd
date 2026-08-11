extends StaticBody2D


var lever_use_active = false


func _ready():
	pass

func _collect(body):
	if "Bug_Corn" in body.name:
		Global.total_stored["corn"] += body.eat_count_kg
		body.queue_free()
	elif "Bug_Wheat" in body.name:
		Global.total_stored["wheat"] += body.eat_count_kg
		body.queue_free()
	elif "Bug_Compound_Food_k1" in body.name:
		Global.total_stored["compound_feed_k1"] += body.eat_count_kg
		body.queue_free()
	elif "Bug_Compound_Food_k2" in body.name:
		Global.total_stored["compound_feed_k2"] += body.eat_count_kg
		body.queue_free()
	elif "Bug_Compound_Food_k3" in body.name:
		Global.total_stored["compound_feed_k3"] += body.eat_count_kg
		body.queue_free()
func _lever_active(body):
	if body.name == "Farmer":
	 lever_use_active = true
func _lever_deactive(body):
	if body.name == "Farmer":
	 lever_use_active = false
func _process(delta):
	if Input.is_action_pressed("action-use") and lever_use_active:
		$ULLayer/ULMenu.popup_centered()
		Global.player_may_move = false
func _validate_input_num(new_text, el_path):
	var valid_text = []
	for el in new_text:
		if el in ['1', '2', '3', '4', '5', '6', '7', '8', '9', '0']:
			valid_text.append(el)
	var valid_string = "".join(valid_text)
	var node = get_node(el_path)
	node.text = valid_string
	node.caret_position = len(valid_string)
func _on_ULwindow_hidden():
	Global.player_may_move = true
func _hide_ULwindow_and_unload():
	# Сбор Информации
	var window = $ULLayer/ULMenu
	var eat_type = window.get_node("VBoxContainer/ItemList").get_selected_items()[0]
	var eat_count_kg = window.get_node("VBoxContainer/LineEdit").text
	# Проверка Информации
	if eat_count_kg  == "":
		# Если пользователь не ввел количество еды то пишем ему об этом и выходим из функции(Чтобы окно не скрылось и разгрузка не выдала ошибку) 
		window.get_node("VBoxContainer/Error").text = "Введите Количество!"
		return
	# Преобразование количества еды в int 
	eat_count_kg = int(eat_count_kg)
	# Закрытие окна и разгрузка еды
	var out = unload_eat(eat_type, eat_count_kg)
	print(out)
	if out == "No enough":
		window.get_node("VBoxContainer/Error").text = "Недостаточно еды"
	else:
		window.hide()
func unload_eat(type, count):
	var bags ={
		"wheat":preload("res://Bug_Wheat.tscn"),
		"corn":preload("res://Bug_Corn.tscn"), 
		"compound_k3":preload("res://Bug_Compound_feed-k3.tscn"),
		"compound_k2":preload("res://Bug_Compound_feed-k2.tscn"),
		"compound_k1":preload("res://Bug_Compound_feed-k1.tscn")
		}
	var street_node = get_tree().get_root().get_node_or_null("Street")
	var bag
	if street_node:
		if type == 0:
			if Global.total_stored["wheat"] >= count:
				Global.total_stored["wheat"] -= count
				bag = bags["wheat"].instance()
			else:
				return "No enough"
		elif type == 1:
			if Global.total_stored["corn"] >= count:
				Global.total_stored["corn"] -= count
				bag = bags["corn"].instance()
			else:
				return "No enough"
		elif type == 2:
			if Global.total_stored["compound_feed_k3"] >= count:
				Global.total_stored["compound_feed_k3"] -= count
				bag = bags["compound_k3"].instance()
			else:
				return "No enough"
		elif type == 3:
			if Global.total_stored["compound_feed_k2"] >= count:
				Global.total_stored["compound_feed_k2"] -= count
				bag = bags["compound_k2"].instance()
			else:
				return "No enough"
		elif type == 4:
			if Global.total_stored["compound_feed_k1"] >= count:
				Global.total_stored["compound_feed_k1"] -= count
				bag = bags["compound_k1"].instance()
			else:
				return "No enough"
		else:
			print(type)
			return
		var farmer = street_node.get_node_or_null("Farmer")
		if bag and farmer:
			street_node.add_child(bag)
			bag.global_position = farmer.global_position + Vector2(0, -50)
			bag.eat_max_kg = count
			bag.eat_count_kg = count
			bag.sleeping = false
			print(bag.global_position)
		else:
			return 
	else:
		print("Street node сейчас Null")
			
		
