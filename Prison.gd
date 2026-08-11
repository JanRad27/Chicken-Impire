extends Control


var prisoner_texture = preload("res://Farmer_Prisoner.png")

# Called when the node enters the scene tree for the first time.
func _ready():
	$Farmer/Sprite.texture = prisoner_texture
	$Arrest.popup_centered()


func _process(delta):
	$Farmer/Sprite.texture = prisoner_texture
	$Time.text = "Осталось " + str(Global.player_arrest_time) + " Секунд до выхода"
