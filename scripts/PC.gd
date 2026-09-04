extends Control

func _ready():
	$Label_Special.visible = false
	
	# Создаем таймер, который будет тикать каждую секунду
	var timer = Timer.new()
	timer.wait_time = 1.0
	timer.autostart = true
	add_child(timer)
	
	# Подключаем таймер к нашей функции каждую секунду
	timer.connect("timeout", self, "_on_second_passed")
	
	# ТО САМОЕ ИСПРАВЛЕНИЕ: Жёстко запускаем таймер вручную!
	timer.start() 


# Эта функция вызывается ровно 1 раз в секунду
func _on_second_passed():
#	if Global.satiety <= 0:
#		print("Курица голодна!")
#		$Label_Special.text = "Курица Голодна!"
#		$Label_Special.visible = true
#	else:
#		$Label_Special.visible = false
	pass
	
				
func go_shop():
	get_tree().change_scene("res://scenes/Shop.tscn")
func poweroff():
	get_tree().change_scene("res://scenes/House_in.tscn")
func go_chinder():
	get_tree().change_scene("res://scenes/ChickenTinder.tscn")
func _process(delta):
	$Label.text = tr("EGGS_TEXT") + ": " + str(Global.eggs) + " | " + tr("SATIETY_TEXT") + ": " + str(Global.satiety) + "%" + " | " + tr("MONEY_TEXT") + ": " + str(Global.money) + "\n" + tr("TIME_TEXT") % [int(Global.game_time.get_time_array()[2]), int(Global.game_time.get_time_array()[1])]
func go_rooster_bank():
	get_tree().change_scene("res://scenes/RoosterBank.tscn")
func menu():
	var dialog = $Quit_dialog
	var dialog_quit = $Quit_dialog/HBoxContainer/Button
	var dialog_decline = $Quit_dialog/HBoxContainer/Button2
	dialog.popup_centered()
	dialog_quit.connect("pressed", self, "quit")
	dialog_decline.connect("pressed", self, "decline_quit")
	yield(dialog, "popup_hide")
func quit():
	get_tree().change_scene("res://scenes/Menu.tscn")
func decline_quit():
	$Quit_dialog.hide()
