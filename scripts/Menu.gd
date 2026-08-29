extends Control


# Called when the node enters the scene tree for the first time.
func _ready():
	pass


# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta):
#	pass

func _start():
	get_tree().change_scene("res://scenes/PC.tscn")
func _quit():
	get_tree().quit()
func _settings():
	get_tree().change_scene("res://Settings.tscn")
