extends Node

var custom_theme: Theme = Theme.new()
var eggs = 0  # Баланс яиц
var satiety = 100 # Сытость фермера
var money = 0  # Деньги
var hugrying_speed = 0.3 # Скорость Голодания
var chickens =  {
	0:{"id":0, "name":"Галина", "satiety":100},
	1:{"id":1, "name":"Ряба", "satiety":100},
	2:{"id":2, "name":"Желтенькая", "satiety":100}
} # Курицы
var fade_screen: ColorRect
var total_stored = {"corn":0, "wheat":0, "compound_feed_k3":0, "compound_feed_k2":0, "compound_feed_k1":0} # Запас еды кур в сарае
var player_may_move = true
var player_arrest_time = 0
var player_arrested = false
var chiken_tinder_posts = [
]
var chicken_first_names 
var chicken_last_names
var chicken_statuses
var now_like_cost = 50 # Сколько сейчас стоит курица
var last_chicken_id
var in_credit: bool = false
var rooster_bank_prison_timer = 0
var credit_summ = {"remaining":0, "start":0}
var window = AcceptDialog.new()
func _ready():
	OS.set_window_title(tr("GAME_NAME"))
	chicken_first_names = [tr("FN_NASETKA_TEXT"), tr("FN_KLUSHA_TEXT"), tr("FN_TSYPA_TEXT"), tr("FN_PESTRUSHKA_TEXT"), tr("FN_RYABA_TEXT")]
	chicken_last_names = [tr("LN_GALINA_TEXT"), tr("LN_ZINA_TEXT"), tr("LN_MARFA_TEXT"), tr("LN_TAMARA_TEXT"), tr("LN_ELENA_TEXT")]
	chicken_statuses = [tr("STATUS_CORN_TEXT"), tr("STATUS_SPONSOR_TEXT"), tr("STATUS_BARN_TEXT"), tr("STATUS_EGGS_TEXT")]
	# Хакерский спавн узла прямо в оперативку без ручного создания на сценах! [321.1]
	fade_screen = ColorRect.new()
	fade_screen.color = Color(0, 0, 0, 0) # Полностью прозрачный чёрный [377.1]
	
	# Делаем так, чтобы узел игнорировал клики мышки и не ломал кнопки игры
	fade_screen.mouse_filter = Control.MOUSE_FILTER_IGNORE
	
	# Вешаем его в CanvasLayer, чтобы он ВСЕГДА был поверх всех камер и домов!
	var canvas = CanvasLayer.new()
	canvas.layer = 100 # Максимальный приоритет отрисовки
	canvas.add_child(fade_screen)
	add_child(canvas)
	# --- Окно - РАБОТА СО ШРИФТОМ ЧЕРЕЗ ТЕМУ ---
	var font_res = load("res://fonts/Roboto_font.tres")

	# 1. Меняем шрифт заголовка (для класса WindowDialog)
	custom_theme.set_font("title_font", "WindowDialog", font_res)

	# 2. Меняем шрифт для обычного текста (для класса Label)
	custom_theme.set_font("font", "Label", font_res)

	# 3. Меняем шрифт для кнопок ОК/Отмена (для класса Button)
	custom_theme.set_font("font", "Button", font_res)

	# Применяем созданную тему к окну
	window.theme = custom_theme
	window.popup_exclusive = true
	canvas.add_child(window)
	# Создаем таймер, который будет тикать каждую секунду
	var timer = Timer.new()
	timer.wait_time = 1.0
	timer.autostart = true
	add_child(timer)
	# Таймер оплаты Roosterbank
	var rooster_bank_timer = Timer.new()
	rooster_bank_timer.wait_time = 10.0
	rooster_bank_timer.autostart = true
	add_child(rooster_bank_timer)
	# Подключаем таймер к нашей функции каждую секунду
	timer.connect("timeout", self, "_update")
	rooster_bank_timer.connect("timeout", self, "credit_pay")
func _update():
	if get_tree().current_scene and not get_tree().current_scene.filename == "res://Menu.tscn":
		for chicken in chickens.values():
			if chicken["satiety"] > 0:
				chicken["satiety"] -= 1 
				eggs += 1
		if not player_arrested:
			satiety -= hugrying_speed
		else:
			player_arrest_time -= 1 
			satiety = 100.0
			if player_arrest_time <= 0:
				player_arrested = false
				get_tree().change_scene("res://scenes/Street.tscn")
		if len(chiken_tinder_posts) < 10:
			generate_chicken_tinder_post()
func _process(_delta):
	if get_tree().current_scene and not get_tree().current_scene.filename == "res://Menu.tscn":
		# Растягиваем его под разрешение экрана твоего ноутбука Acer [221.1, 395.1]
		if fade_screen:
			fade_screen.rect_size = get_viewport().size
		for chicken in chickens.values():
			if chicken["satiety"] > 100:
				chicken["satiety"] = 100
		if satiety <= 0:
			satiety = 100.0
			fade()
		for chicken in chickens.values():
			last_chicken_id = chicken["id"]
		for post in chiken_tinder_posts:
			if post["id"] > last_chicken_id:
				last_chicken_id = post["id"]
		if rooster_bank_prison_timer >= 10:
			var true_summ = int(credit_summ["remaining"])
			clear_credit()
			window.window_title = "КуроГрамм: ПетухБанк - Сообщение"
			window.dialog_text = "Срок выплаты кредита истек! Вы будете отправлены в тюрьму на " + str(true_summ) + " секунд!"
			window.popup_centered()
			yield(window, "popup_hide")
			arrest(true_summ)
		if credit_summ["remaining"] <= 0 and in_credit:
			clear_credit()
func hungry_farmer(points):
	satiety -= points
func fade():
	# Плавно делаем глобальный экран чёрным везде! [493.1]
	for i in range(20):
		fade_screen.color.a += 0.05
		yield(get_tree().create_timer(0.05), "timeout")
		
	# Жёсткие экономические санкции Новогрудской больницы! [471.1, 474.1]
	satiety = 100.0 # Подлечили капельницей
	
	# Телепортируем игрока в больницу из любой точки мира! [471.1, 478.1]
	get_tree().change_scene("res://Hospital.tscn")
	
	# Плавно делаем экран обратно прозрачным на койке [471.1]
	yield(get_tree().create_timer(0.5), "timeout")
	for i in range(20):
		fade_screen.color.a -= 0.05
		yield(get_tree().create_timer(0.03), "timeout")
func pay(points):
	money -= points
func arrest(time):
	player_may_move = false
	
	var sound_player = AudioStreamPlayer.new()	
	add_child(sound_player)
	
	# Загрузка MP3 файла
	var music = load("res://sounds/police.mp3")
	sound_player.stream = music
	
	sound_player.play()
	var tween = create_tween().set_loops(10)
	tween.tween_property(fade_screen, "color", Color8(3, 19, 252, 50), 0.2)
	tween.tween_property(fade_screen, "color", Color8(252, 3, 3, 50), 0.2)
	
	yield(tween, "finished")
	# Останавливаем анимацию мерцания
	tween.kill()
	sound_player.queue_free()
	
	player_arrested = true
	player_arrest_time = time
	fade_screen.color = Color(0, 0, 0, 0)
	# Плавно делаем глобальный экран чёрным везде! [493.1]
	for i in range(20):
		fade_screen.color.a += 0.05
		yield(get_tree().create_timer(0.05), "timeout")
	
	get_tree().change_scene("res://scenes/Prison.tscn")
	for i in range(20):
		fade_screen.color.a -= 0.05
		yield(get_tree().create_timer(0.05), "timeout")
	player_may_move = true

func generate_chicken_tinder_post():
	if last_chicken_id == null:
		return
	# Сбор данных
	var chicken_name
	var chicken_first_name
	var chicken_last_name
	var chicken_status
	var chicken_id = last_chicken_id + 1
	var chicken_cost = now_like_cost
	var random_generator = RandomNumberGenerator.new()
	random_generator.randomize()
	chicken_first_name = chicken_first_names[random_generator.randi_range(0, len(chicken_first_names) - 1)]
	random_generator.randomize()
	chicken_last_name = chicken_last_names[random_generator.randi_range(0, len(chicken_last_names) - 1)]
	chicken_name = chicken_first_name + " " + chicken_last_name
	chicken_status = chicken_statuses[random_generator.randi_range(0, len(chicken_statuses) - 1)]
	# Формируем словарь для chicken_tinder_posts
	var post = {"name":chicken_name, "about":chicken_status, "id":chicken_id, "like_cost":chicken_cost}
	# Завершение: Добавляем анкету и повышаем цену следующей куры на 10 руб.
	chiken_tinder_posts.append(post)
	now_like_cost += 10
func credit_pay():
	if get_tree().current_scene and not get_tree().current_scene.filename == "res://Menu.tscn":
		if in_credit:
			var need_to_pay = credit_summ["start"] * 5 / 100.0
			if money >= need_to_pay:
				money -= need_to_pay
				credit_summ["remaining"] -= need_to_pay
			else:
				rooster_bank_prison_timer += 1
				print(rooster_bank_prison_timer)
func add_credit(summ, add_procent):
	var summ_true = summ + (summ * add_procent / 100.0) 
	print(summ_true)
	credit_summ["start"] = summ_true
	credit_summ["remaining"] = summ_true
	in_credit = true
	money += summ
	window.window_title = "КуроГрамм: ПетухБанк - Сообщение"
	window.dialog_text = "Внимание! Вы взяли кредит на сумму " + str(summ) + " рублей, вернете "  + str(summ_true) + " рублей! Если это не вы обратитесь в поддержку."
	window.popup_centered()
	yield(window, "popup_hide")
func clear_credit():
	credit_summ["start"] = 0
	credit_summ["remaining"] = 0
	in_credit = false
	rooster_bank_prison_timer = 0
func rooster_bank_push(text):
	window.window_title = tr("ROOSTERBANKPUSH_TEXT")
	window.dialog_text = text
	window.popup_centered()
func _update_languages():
	OS.set_window_title(tr("GAME_NAME"))
	chicken_first_names = [tr("FN_NASETKA_TEXT"), tr("FN_KLUSHA_TEXT"), tr("FN_TSYPA_TEXT"), tr("FN_PESTRUSHKA_TEXT"), tr("FN_RYABA_TEXT")]
	chicken_last_names = [tr("LN_GALINA_TEXT"), tr("LN_ZINA_TEXT"), tr("LN_MARFA_TEXT"), tr("LN_TAMARA_TEXT"), tr("LN_ELENA_TEXT")]
	chicken_statuses = [tr("STATUS_CORN_TEXT"), tr("STATUS_SPONSOR_TEXT"), tr("STATUS_BARN_TEXT"), tr("STATUS_EGGS_TEXT")]
	chiken_tinder_posts.clear()
