extends Control


# Called when the node enters the scene tree for the first time.
func _ready():
	TranslationServer.set_locale("en")


# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta):
#	pass

func _start():
	get_tree().change_scene("res://PC.tscn")
func _quit():
	get_tree().quit()
