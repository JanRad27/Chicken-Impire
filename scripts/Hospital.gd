extends Control


func _ready():
	# Показываем окно строго по центру палаты
	$Pay.popup_centered()
	
	# ХАКЕРСКИЙ ПЕРЕХВАТ КРЕСТИКА:
	# Находим физическую кнопку-крестик в углу окна и привязываем decline_pay строго к её клику!
	var close_btn = $Pay.get_close_button()
	if close_btn:
		close_btn.connect("pressed", self, "decline_pay")

func out(body):
	if body.name == "Farmer":
		get_tree().change_scene("res://Street.tscn")

func _pay():
	if int(Global.money) >= 50:
		Global.money -= 50 # Прямое вычитание в обход лагающих функций!
		Global.rooster_bank_push(tr("WRITTENOFF_TEXT") + ": 50" + tr("COINS_TEXT") + "\n" + tr("REMAINING_TEXT") + str(Global.money))
	else:
		Global.add_credit(50, 100)
		Global.money -= 50
		Global.rooster_bank_push(tr("WRITTENOFF_TEXT") + ": 50 " + tr("COINS_TEXT") + "\n" + tr("REMAINING_TEXT") + str(Global.money))
func decline_pay():
		Global.arrest(30)



