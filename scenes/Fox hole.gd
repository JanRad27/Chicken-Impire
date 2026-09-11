extends StaticBody2D

var fox_scene = preload("res://scenes/Fox.tscn")
onready var path: NodePath = get_path()
var my_fox

# Called when the node enters the scene tree for the first time.
func _ready():
	Debug.add_log("Fox hole ready!")


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	if int(Global.game_time.get_time_array()[2]) < 7:
		spawn_fox()

func spawn_fox():
	if my_fox:
		return
	my_fox = fox_scene.instance()
	my_fox.hole = path
	get_parent().add_child(my_fox)
	my_fox.global_position = global_position
	
	my_fox.move_and_slide(Vector2.ZERO) # Вытолкнуть лису из норы!
