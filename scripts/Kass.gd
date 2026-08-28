extends StaticBody2D



# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.


func _enter(body):
	if body.name == "Farmer":
		 get_tree().change_scene("res://scenes/In_Kass.tscn")
