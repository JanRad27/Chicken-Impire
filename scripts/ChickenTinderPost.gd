extends Control

export(String) var chicken_name = "name"
export(String) var chicken_about = "about"
export(int) var like_cost = 50
export(int) var chicken_id = 0
export(String, "basic", "giga") var type


# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(_delta):
	$Name.text = chicken_name
	$Me.text = chicken_about
	$HBoxContainer2/Label.text = tr("LIKECOST_TEXT") % like_cost
	if type == "basic":
		$TextureRect.texture = load("res://images/Chicken.png")
	elif type == "giga":
		$TextureRect.texture = load("res://images/Gigachicken.png")
	
func _liked():
	if Global.money >= like_cost:
		$HBoxContainer/LikeButton.texture_normal = load("res://images/Like_Pressed.png")
		yield(get_tree().create_timer(3.0), "timeout")
		Global.money -= like_cost
		Global.chickens[chicken_id] = {"id":chicken_id, "name":chicken_name, "satiety":100, "type":type}
		for post in Global.chiken_tinder_posts:
			if post["id"] == chicken_id:
				Global.chiken_tinder_posts.erase(post)
		queue_free()
func _disliked():
	queue_free()
	
func setup_card(name, id, about, slike_cost, stype):
	chicken_name = name
	chicken_id = id
	chicken_about = about
	like_cost = slike_cost
	type = stype
