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
	if Global.satiety <= 0:
		print("Курица голодна!")
		$Label_Special.text = "Курица Голодна!"
		$Label_Special.visible = true
	else:
		$Label_Special.visible = false
	
				
func go_shop():
	get_tree().change_scene("res://Shop.tscn")
func poweroff():
	get_tree().change_scene("res://House_in.tscn")
func go_chinder():
	get_tree().change_scene("res://ChickenTinder.tscn")
func _process(delta):
	$Label.text = "Яйца: " + str(Global.eggs) + " | Сытость: " + str(Global.satiety) + "%" + " | Деньги: " + str(Global.money)
func go_rooster_bank():
	get_tree().change_scene("res://RoosterBank.tscn")
