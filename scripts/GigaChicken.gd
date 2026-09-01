extends KinematicBody2D
export(int) var speed = 120
var target: Vector2 = Vector2(500, 500)
var velocity: Vector2 = Vector2.ZERO
var fox_in_vision: Dictionary = {"in_vision":false, "fox":null}

func _ready():
	pass
	
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
		target = global_position
		fox_in_vision = {"in_vision":false, "fox":null}
		
