extends Node

var is_debug = false

# Called when the node enters the scene tree for the first time.
func _ready():
	if "--mode=debug" in OS.get_cmdline_args():
		is_debug = true
		print("Debug mode actived! starting debug...")
	else:
		queue_free()
func add_log(text: String):
	if is_debug:
		print("Debug logs -> " + text)
func _exit_tree():
	if is_debug:
		print("Debuging stopped!")
