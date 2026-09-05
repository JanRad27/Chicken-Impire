extends Control

var post_scene = preload("res://scenes/ChickenTinderPost.tscn")


# Called when the node enters the scene tree for the first time.
func _ready():
	for post in Global.chiken_tinder_posts:
		var new_post = post_scene.instance()
		$Scroll/VBoxContainer.add_child(new_post)
		new_post.rect_min_size = Vector2(200, 200)
		new_post.setup_card(post["name"], post["id"], post["about"], post["like_cost"], post["type"])
	Debug.add_log("Tinder ready!")

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	var current_ui_cards = $Scroll/VBoxContainer.get_child_count()
	
	if Global.chiken_tinder_posts.size() > current_ui_cards:
		# Берем самую свежую куру из конца массива и спавним её в свиток!
		var fresh_data = Global.chiken_tinder_posts.back()
		
		var new_post = post_scene.instance()
		$Scroll/VBoxContainer.add_child(new_post)
		
		# Задаем данные Галине или Пете на лету!
		new_post.setup_card(fresh_data["name"], fresh_data["id"], fresh_data["about"], fresh_data["like_cost"], fresh_data["type"])

func _out():
	get_tree().change_scene("res://scenes/PC.tscn")
