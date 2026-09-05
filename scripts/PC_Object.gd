extends StaticBody2D



# Called when the node enters the scene tree for the first time.
func _ready():
	Debug.add_log("PC object ready!")

func poweron(body):
	if body.name == "Farmer":
	 get_tree().change_scene("res://scenes/PC.tscn")
