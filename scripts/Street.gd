extends Control

var Chicken_scene = preload("res://scenes/Chicken.tscn.tscn")
var GChicken_scene = preload("res://scenes/GigaChicken.tscn")
var RMillioner_scene = preload("res://scenes/RoosterMillioner.tscn")

# Called when the node enters the scene tree for the first time.
func _ready():
	var chicken_x = 0
	for chicken in Global.chickens:
			var chick
			if chicken["type"] == "basic" or chicken["type"] == "white":
				chick = Chicken_scene.instance()
				chick.global_position = Vector2(chicken_x, 0)
				chick.chicken_id = chicken["id"]
				chick.type = "red" if chicken["type"] == "basic" else "white"
			elif chicken["type"] == "giga":
				chick = GChicken_scene.instance()
				chick.base_position = Vector2(chicken_x, 100)
			elif chicken["type"] == "millioner":
				chick = RMillioner_scene.instance()
				chick.global_position = Vector2(chicken_x, 50)
				chick.chicken_id = chicken["id"]
			add_child(chick)
			chicken_x += 50
			chick.move_and_slide(Vector2.ZERO)
	Debug.add_log("Street ready!")


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass
