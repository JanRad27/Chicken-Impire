extends KinematicBody2D
export(int) var speed = 120
var target: Vector2 = Vector2(500, 500)
var velocity: Vector2 = Vector2.ZERO
var fox_in_vision: Dictionary = {"in_vision":false, "fox":null}
export(Vector2) var base_position

func _ready():
	var pos_update_timer = Timer.new()
	pos_update_timer.wait_time = 5.0
	pos_update_timer.autostart = true
	add_child(pos_update_timer)
	
	pos_update_timer.connect("timeout", self, "update_pos")
	
	Debug.add_log("GigaChicken spawned!")
	
func _process(delta):
	velocity = Vector2.ZERO
	if fox_in_vision["in_vision"]:
		target = fox_in_vision["fox"].global_position
	if target != Vector2.ZERO and global_position.distance_to(target) > 10:
		var direction = (target - global_position).normalized()
		velocity = direction * speed
	else:
		target = Vector2.ZERO
		
	move_and_slide(velocity)
		


func _detect(body):
	if "Fox" in body.name:
		fox_in_vision = {"in_vision":true, "fox":body}
func _undetect(body):
	if "Fox" in body.name:
		target = Vector2.ZERO
		fox_in_vision = {"in_vision":false, "fox":null}
func update_pos():
	if not fox_in_vision["in_vision"]:
		target = base_position
		
