extends Node
class_name BackgroundMusicServer, "res://images/Player.png"
tool
var audio: String
var player: AudioStreamPlayer
var volume: int = 1
var auto_play: bool = true

func _ready():
	self.name = "BackgroundMusicServer"
	player = AudioStreamPlayer.new()
	add_child(player)
	player.bus = "Master"
	if not Engine.editor_hint and not get_parent() is Viewport:
		yield(get_tree(), "idle_frame")
		if get_tree().get_root().get_node_or_null("BackgroundMusicServer"):
			queue_free()
		var root_node = get_tree().get_root()
		get_parent().remove_child(self)
		print(get_parent(), self)
		root_node.add_child(self)
	yield(get_tree(), "idle_frame")
	if get_parent() is Viewport and auto_play:
		self.play()


func play():
		player.stream = load(audio)
		player.volume_db = volume
		
		player.play()
		
func set_audio(path: String):
	audio = path
	
	player.stream = load(audio)

func stop():
	player.stop()

func _get_property_list():
	var properties = []
	
	# 1. 🔥 СОЗДАЕМ ТВОЮ КАСТ ОМНУЮ ГРУППУ! (Заменяет надпись Script Variables)
	properties.append({
		"name": "BackgroundMusicServer",
		"type": TYPE_NIL,
		"usage": PROPERTY_USAGE_CATEGORY # Объявляем это как главный заголовок категории!
	})
	
	# 2. Нативно привязываем свойство выбора MP3-файла внутрь этой группы
	properties.append({
		"name": "audio",
		"type": TYPE_STRING,
		"hint": PROPERTY_HINT_FILE,
		"hint_string": "*.mp3,*.ogg,*.wav"
	})
	
	# 3. Привязываем слайдер громкости
	properties.append({
		"name": "volume",
		"type": TYPE_REAL,
		"hint": PROPERTY_HINT_RANGE,
		"hint_string": "-60.0,24.0"
	})
	properties.append({
		"name": "auto_play",
		"type": TYPE_BOOL,
	})
	
	return properties
