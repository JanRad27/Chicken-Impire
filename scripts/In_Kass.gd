extends Control

var egg_call = 0
var randomizer: RandomNumberGenerator


# Called when the node enters the scene tree for the first time.
func _ready():
	randomizer = RandomNumberGenerator.new()
	randomizer.randomize()
	
	egg_call = randomizer.randi_range(1, 50)
	Debug.add_log("Kass ready!")

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	$Label.text = tr("KASSLABEL_TEXT") % [Global.eggs, egg_call, Global.money]
	
func _sell_eggs():
	if Global.eggs < egg_call:
		$Output.text = tr("NOENOUGHEGGS_TEXT")
		$Output.visible = true
		Debug.add_log("Egg selling error: No enough eggs!")
	else:
		Global.eggs -= egg_call
		Global.money += egg_call * 1.5
		$Output.text = tr("SELLED_TEXT")
		$Output.visible = true
		randomizer.randomize()
		egg_call = randomizer.randi_range(1, 50)
		Debug.add_log("Egg selled! Money now:" + str(Global.money))
func out():
	get_tree().change_scene("res://scenes/Street.tscn")
