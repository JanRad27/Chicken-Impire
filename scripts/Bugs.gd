extends RigidBody2D

export(int) var eat_count_kg = 50 # Выставил в инспекторе 50 кг!
export(int) var eat_max_kg = 50
export(int) var eat_satiety = 5

func _ready():
	# ТРАВЯНОЕ ТРЕНИЕ: Значение 8.0 или 10.0 намертво остановит мешок после пинка!
	linear_damp = 8.0 
	angular_damp = 10.0 # Чтобы мешок не вращался как сумасшедший волчок

func _process(delta):
	mass = eat_count_kg
	if eat_count_kg > eat_max_kg:
		eat_count_kg = eat_max_kg
		
	$eat_count_bar.max_value = eat_max_kg
	$eat_count_bar.value = eat_count_kg
