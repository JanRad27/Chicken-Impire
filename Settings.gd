extends Control


# Declare member variables here. Examples:
# var a = 2
# var b = "text"


# Called when the node enters the scene tree for the first time.
func _ready():
	var locale = TranslationServer.get_locale().substr(0, 2)
	var nums = {
	"ru":0,
	"en":1
	}
	var locale_num = nums[locale]
	$ScrollContainer/VBoxContainer/OptionButton.select(locale_num)

func _menu():
	get_tree().change_scene("res://scenes/Menu.tscn")

# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta):
#	pass


func _change_language(index):
	if index == 0:
		TranslationServer.set_locale("ru")
	elif index == 1:
		TranslationServer.set_locale("en")
	Global._update_languages()
