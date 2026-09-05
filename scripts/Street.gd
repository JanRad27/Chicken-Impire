extends Control

var Chicken_scene = preload("res://scenes/Chicken.tscn.tscn")
var GChicken_scene = preload("res://scenes/GigaChicken.tscn")

# Called when the node enters the scene tree for the first time.
func _ready():
	var chicken_x = 0
	for chicken in Global.chickens.values():
			var chick
			if chicken["type"] == "basic":
				chick = Chicken_scene.instance()
				chick.chicken_id = chicken["id"]
			elif chicken["type"] == "giga":
				chick = GChicken_scene.instance()
				chick.base_position = Vector2(chicken_x, 50)
			add_child(chick)
			chick.global_position = Vector2(chicken_x, 0)
			chicken_x += 50
	Debug.add_log("Street ready!")


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass
