extends StaticBody2D




# Called when the node enters the scene tree for the first time.
func _ready():
	pass

func enter(body):
	if body.name == "Farmer":
		get_tree().change_scene("res://House_in.tscn")

