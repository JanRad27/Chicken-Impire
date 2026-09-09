extends KinematicBody2D

var security_scene = preload("res://scenes/GigaChicken.tscn")
var security
# Declare member variables here. Examples:
# var a = 2
# var b = "text"


# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta):
#	pass


func _detect(body):
	if "Fox" in body.name:
		if security:
			return
		security = security_scene.instance()
		add_child(security)
		security.global_position = global_position
		security.base_position = global_position
		
		security.move_and_slide(Vector2.ZERO) # Выталкиваем этого Цыпу-Гигачада из себя!
		
func _undetect(body):
	if "Fox" in body.name:
		remove_child(security)
		security = null
		
