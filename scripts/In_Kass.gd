extends Control

var egg_call = 0
var randomizer: RandomNumberGenerator


# Called when the node enters the scene tree for the first time.
func _ready():
	randomizer = RandomNumberGenerator.new()
	randomizer.randomize()
	
	egg_call = randomizer.randi_range(1, 50)


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	$Label.text = "Яйца: " + str(Global.eggs) + " | Запрос Яиц: " + str(egg_call) + " | Деньги: " + str(Global.money)
	
func _sell_eggs():
	if Global.eggs < egg_call:
		$Output.text = "Недостаточно яиц!"
		$Output.visible = true
	else:
		Global.eggs -= egg_call
		Global.money += egg_call * 1.5
		$Output.text = "Успешно продано!"
		$Output.visible = true
		randomizer.randomize()
		egg_call = randomizer.randi_range(1, 50)
func out():
	get_tree().change_scene("res://scenes/Street.tscn")
