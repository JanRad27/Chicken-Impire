extends Control

onready var special_label = $"TabContainer/Еда для курей/ScrollContainer/VBoxContainer/Label"
onready var special_label_eat = $"TabContainer/Бройлерский Ресторан/ScrollContainer/VBoxContainer/Label"
func buy_corn():
	if Global.money >= 30:
		Global.money -= 30       # Не забываем забрать 30 яиц за покупку!
		Global.total_stored["corn"] += 30
		
			
		special_label.text = "Успешно куплена кукуруза запас стал: " +  str(Global.total_stored["corn"])
		special_label.visible = true
	else:
		special_label.text = "Недостаточно денег осталось ещё " + str(30 - Global.money) + " Рублей для покупки"
		special_label.visible = true
		
func buy_wheat():
	if Global.money >= 60:
		Global.money -= 60     # Не забываем забрать 60 яиц за покупку!
		Global.total_stored["wheat"] += 30
			
		special_label.text = "Успешно куплена пшеница запас стал: " + str(Global.total_stored["wheat"])
		special_label.visible = true
	else:
		special_label.text = "Недостаточно денег осталось ещё " + str(60 - Global.money) + " Рублей для покупки"
		special_label.visible = true
func buy_compound_feed(category):
	if category == 3:
		if Global.money >= 90:
			Global.money -= 90     # Не забываем забрать 90 яиц за покупку!
			Global.total_stored["compound_feed_k3"] += 30
				
			special_label.text = "Успешно куплен комбикорм К-3 запас: " + str(Global.total_stored["compound_feed_k3"])
			special_label.visible = true
		else:
			special_label.text = "Недостаточно денег осталось ещё " + str(90 - Global.money) + " Рублей для покупки"
			special_label.visible = true
	if category == 2:
		if Global.money >= 120:
			Global.money -= 120     # Не забываем забрать 120 яиц за покупку!
			Global.total_stored["compound_feed_k2"] += 20
				
			special_label.text = "Успешно куплен комбикорм К-2 запас стал: " + str(Global.total_stored["compound_feed_k2"])
			special_label.visible = true
		else:
			special_label.text = "Недостаточно денег осталось ещё " + str(120 - Global.money) + " Рублей для покупки"
			special_label.visible = true
	if category == 1:
		if Global.money >= 150:
			Global.money -= 150   # Не забываем забрать 150 яиц за покупку!
			Global.total_stored["compound_feed_k1"] += 30
						
			special_label.text = "Успешно куплен комбикорм К-1 запас стал: " + str(Global.total_stored["compound_feed_k1"])
			special_label.visible = true
		else:
					special_label.text = "Недостаточно денег осталось ещё " + str(150 - Global.money) + " Рублей для покупки"
					special_label.visible = true
func go_home():
	get_tree().change_scene("res://PC.tscn")
func buy_dry_rations():
	if Global.money >= 3:
		Global.money -= 3
		Global.satiety += 5
		
		if Global.satiety > 100:
			Global.satiety = 100
		
		special_label_eat.text = "Успешно куплен и съеден сухой паек сытость стала: " + str(Global.satiety)
		special_label_eat.visible = true
	else:
		special_label_eat.text = "Недостаточно денег осталось ещё " + str(3 - Global.money) + " Рублей до покупки"
		special_label_eat.visible = true
func buy_pasta_sosiski():
	if Global.money >= 5:
		Global.money -= 5
		Global.satiety += 7
		
		if Global.satiety > 100:
			Global.satiety = 100
		
		special_label_eat.text = "Успешно куплены и съедены макароны с сосиками сытость стала: " + str(Global.satiety)
		special_label_eat.visible = true
	else:
		special_label_eat.text = "Недостаточно денег осталось ещё " + str(5 - Global.money) + " Рублей до покупки"
		special_label_eat.visible = true

func buy_pasta_tysenka():
	if Global.money >= 7:
		Global.money -= 7
		Global.satiety += 10
		
		if Global.satiety > 100:
			Global.satiety = 100
		
		special_label_eat.text = "Успешно куплены и съедены макароны с тушенкой сытость стала: " + str(Global.satiety)
		special_label_eat.visible = true
	else:
		special_label_eat.text = "Недостаточно денег осталось ещё " + str(7 - Global.money) + " Рублей до покупки"
		special_label_eat.visible = true
func buy_potato_tysenka():
	if Global.money >= 10:
		Global.money -= 10
		Global.satiety += 15
		
		if Global.satiety > 100:
			Global.satiety = 100
		
		special_label_eat.text = "Успешно куплена и съедена картошка с сосиками сытость стала: " + str(Global.satiety)
		special_label_eat.visible = true
	else:
		special_label_eat.text = "Недостаточно денег осталось ещё " + str(10 - Global.money) + " Рублей до покупки"
		special_label_eat.visible = true
func buy_belyash():
	if Global.money >= 15:
		Global.money -= 15
		Global.satiety += 30
		
		if Global.satiety > 100:
			Global.satiety = 100
		
		special_label_eat.text = "Успешно куплен и съеден беляш сытость стала: " + str(Global.satiety)
		special_label_eat.visible = true
	else:
		special_label_eat.text = "Недостаточно денег осталось ещё " + str(15 - Global.money) + " Рублей до покупки"
		special_label_eat.visible = true
