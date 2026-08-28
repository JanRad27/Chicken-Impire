extends Control


# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta):
#	pass

func go_credits():
	$Main.visible = false
	$"My Balance".visible = false
	$Credits.visible = true 
func go_main():
	$Main.visible = true
	$"My Balance".visible = false
	$Credits.visible = false
func go_my_balance():
	$Main.visible = false
	$"My Balance".visible = true
	$Credits.visible = false
func open_add_credit():
	$Credits/AddCredit.popup_centered()
func _validate_input_num(new_text, el_path):
	var valid_text = []
	for el in new_text:
		if el in ['1', '2', '3', '4', '5', '6', '7', '8', '9', '0']:
			valid_text.append(el)
	var valid_string = "".join(valid_text)
	var node = get_node(el_path)
	node.text = valid_string
	node.caret_position = len(valid_string)
func confirm_credit():
	var summ = int($Credits/AddCredit/VBoxContainer/LineEdit.text)
	if summ != 0:
		$Credits/AddCredit.hide()
		Global.add_credit(summ, 50)
func _process(delta):
	$Credits/Info.dialog_text = ("Кредит взят: " + ("Да\n" if Global.in_credit else "Нет\n")) + "Сумма Кредита: " + str(Global.credit_summ["start"]) + "\nОсталось Выплатить: " + str(Global.credit_summ["remaining"])
	$"My Balance/Balance".text = tr("MYBALANCE_TEXT") + " " + str(Global.money) + " " + tr("COINS_TEXT")
func show_credit():
	$Credits/Info.popup_centered()
func go_quit():
	get_tree().change_scene("res://scenes/PC.tscn")
