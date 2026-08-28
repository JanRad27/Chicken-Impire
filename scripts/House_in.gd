extends Control




# Called when the node enters the scene tree for the first time.
func _ready():
	pass


func out(body):
	if body.name == "Farmer":
	 get_tree().change_scene("res://scenes/Street.tscn")
