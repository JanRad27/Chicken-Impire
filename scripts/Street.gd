extends Control

var Chicken_scene = preload("res://scenes/Chicken.tscn.tscn")


# Called when the node enters the scene tree for the first time.
func _ready():
	var chicken_x = 0
	for chicken in Global.chickens.values():
			var chick = Chicken_scene.instance()
			add_child(chick)
			chick.global_position = Vector2(chicken_x, 0)
			chick.chicken_id = chicken["id"]
			chicken_x += 50


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass
