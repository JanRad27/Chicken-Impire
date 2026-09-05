extends Control




# Called when the node enters the scene tree for the first time.
func _ready():
	Debug.add_log("House ready!")


func out(body):
	if body.name == "Farmer":
	 get_tree().change_scene("res://scenes/Street.tscn")
