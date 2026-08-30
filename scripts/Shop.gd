extends Control

onready var special_label = $"TabContainer/CHICKENEAT_TAB/ScrollContainer/VBoxContainer/Label"
onready var special_label_eat = $"TabContainer/BROILERREST_TAB/ScrollContainer/VBoxContainer/Label"
func buy_corn():
	if Global.money >= 30:
		Global.money -= 30       # Не забываем забрать 30 яиц за покупку!
		Global.total_stored["corn"] += 30
		Global.rooster_bank_push(tr("WRITTENOFF_TEXT") + ": " + "30" + " " + tr("COINS_TEXT") + "\n" + tr("REMAINING_TEXT") + str(Global.money) + " " + tr("COINS_TEXT"))
			
		special_label.text = tr("BOUGHTCORN_TEXT") +  str(Global.total_stored["corn"])
		special_label.visible = true
	else:
		special_label.text = tr("NOENOUGHMONEY_TEXT") % (30 - Global.money)
		special_label.visible = true
		
func buy_wheat():
	if Global.money >= 60:
		Global.money -= 60     # Не забываем забрать 60 яиц за покупку!
		Global.total_stored["wheat"] += 30
		Global.rooster_bank_push(tr("WRITTENOFF_TEXT") + ": " + "60" + " " + tr("COINS_TEXT") + "\n" + tr("REMAINING_TEXT") + str(Global.money) + " " + tr("COINS_TEXT"))
			
		special_label.text = tr("BOUGHTWHEAT_TEXT") + str(Global.total_stored["wheat"])
		special_label.visible = true
	else:
		special_label.text = tr("NOENOUGHMONEY_TEXT") % (60 - Global.money)
		special_label.visible = true
func buy_compound_feed(category):
	if category == 3:
		if Global.money >= 90:
			Global.money -= 90     # Не забываем забрать 90 яиц за покупку!
			Global.total_stored["compound_feed_k3"] += 30
			Global.rooster_bank_push(tr("WRITTENOFF_TEXT") + ": " + "90" + " " + tr("COINS_TEXT") + "\n" + tr("REMAINING_TEXT") + str(Global.money) + " " + tr("COINS_TEXT"))
				
			special_label.text = tr("BOUGHTCOMPOUND3_TEXT") + str(Global.total_stored["compound_feed_k3"])
			special_label.visible = true
		else:
			special_label.text = tr("NOENOUGHMONEY_TEXT") % (90 - Global.money)
			special_label.visible = true
	if category == 2:
		if Global.money >= 120:
			Global.money -= 120     # Не забываем забрать 120 яиц за покупку!
			Global.total_stored["compound_feed_k2"] += 20
			Global.rooster_bank_push(tr("WRITTENOFF_TEXT") + ": " + "120" + " " + tr("COINS_TEXT") + "\n" + tr("REMAINING_TEXT") + str(Global.money) + " " + tr("COINS_TEXT"))
				
			special_label.text = tr("BOUGHTCOMPOUND2_TEXT") + str(Global.total_stored["compound_feed_k2"])
			special_label.visible = true
		else:
			special_label.text = tr("NOENOUGHMONEY_TEXT") % (120 - Global.money)
			special_label.visible = true
	if category == 1:
		if Global.money >= 150:
			Global.money -= 150   # Не забываем забрать 150 яиц за покупку!
			Global.total_stored["compound_feed_k1"] += 30
			Global.rooster_bank_push(tr("WRITTENOFF_TEXT") + ": " + "150" + " " + tr("COINS_TEXT") + "\n" + tr("REMAINING_TEXT") + str(Global.money) + " " + tr("COINS_TEXT"))
						
			special_label.text = tr("BOUGHTCOMPOUND1_TEXT") + str(Global.total_stored["compound_feed_k1"])
			special_label.visible = true
		else:
			special_label.text = tr("NOENOUGHMONEY_TEXT") % (150 - Global.money)
			special_label.visible = true
func go_home():
	get_tree().change_scene("res://scenes/PC.tscn")
func buy_dry_rations():
	if Global.money >= 3:
		Global.money -= 3
		Global.satiety += 5
		Global.rooster_bank_push(tr("WRITTENOFF_TEXT") + ": " + "3" + " " + tr("COINS_TEXT") + "\n" + tr("REMAINING_TEXT") + str(Global.money) + " " + tr("COINS_TEXT"))
		
		if Global.satiety > 100:
			Global.satiety = 100
		
		special_label_eat.text = tr("BOUGHTDRYRAT_TEXT") + str(Global.satiety)
		special_label_eat.visible = true
	else:
		special_label_eat.text = tr("NOENOUGHMONEY_TEXT") % (3 - Global.money)
		special_label_eat.visible = true
func buy_pasta_sosiski():
	if Global.money >= 5:
		Global.money -= 5
		Global.satiety += 7
		Global.rooster_bank_push(tr("WRITTENOFF_TEXT") + ": " + "5" + " " + tr("COINS_TEXT") + "\n" + tr("REMAINING_TEXT") + str(Global.money) + " " + tr("COINS_TEXT"))
		
		if Global.satiety > 100:
			Global.satiety = 100
		
		special_label_eat.text = tr("BOUGHTSAUSAGESPASTA_TEXT") + str(Global.satiety)
		special_label_eat.visible = true
	else:
		special_label_eat.text = tr("NOENOUGHMONEY_TEXT") % (5 - Global.money)
		special_label_eat.visible = true

func buy_pasta_tysenka():
	if Global.money >= 7:
		Global.money -= 7
		Global.satiety += 10
		Global.rooster_bank_push(tr("WRITTENOFF_TEXT") + ": " + "7" + " " + tr("COINS_TEXT") + "\n" + tr("REMAINING_TEXT") + str(Global.money) + " " + tr("COINS_TEXT"))
		
		if Global.satiety > 100:
			Global.satiety = 100
		
		special_label_eat.text = tr("BOUGHTSTEWPASTA_TEXT") + str(Global.satiety)
		special_label_eat.visible = true
	else:
		special_label_eat.text = tr("NOENOUGHMONEY_TEXT") % (7 - Global.money)
		special_label_eat.visible = true
func buy_potato_tysenka():
	if Global.money >= 10:
		Global.money -= 10
		Global.rooster_bank_push(tr("WRITTENOFF_TEXT") + ": " + "10" + " " + tr("COINS_TEXT") + "\n" + tr("REMAINING_TEXT") + str(Global.money) + " " + tr("COINS_TEXT"))
		Global.satiety += 15
		
		if Global.satiety > 100:
			Global.satiety = 100
		
		special_label_eat.text = tr("BOUGHTSTEWPOTATO_TEXT") + str(Global.satiety)
		special_label_eat.visible = true
	else:
		special_label_eat.text = tr("NOENOUGHMONEY_TEXT") % (10 - Global.money)
		special_label_eat.visible = true
func buy_belyash():
	if Global.money >= 15:
		Global.money -= 15
		Global.rooster_bank_push(tr("WRITTENOFF_TEXT") + ": " + "15" + " " + tr("COINS_TEXT") + "\n" + tr("REMAINING_TEXT") + str(Global.money) + " " + tr("COINS_TEXT"))
		Global.satiety += 30
		
		if Global.satiety > 100:
			Global.satiety = 100
		
		special_label_eat.text = tr("BOUGHTBELYASH_TEXT") + str(Global.satiety)
		special_label_eat.visible = true
	else:
		special_label_eat.text = tr("NOENOUGHMONEY_TEXT") % (15 - Global.money)
		special_label_eat.visible = true
