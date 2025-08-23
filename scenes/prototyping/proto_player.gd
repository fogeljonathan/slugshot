extends Node2D

var speed:float = 1.

var accel:float = 5.
var deccel:float = 10.
var max_speed:float = 20.

func _process(delta):
	var dir:Vector2 = Vector2(0, 0)
	if Input.is_action_pressed("move_left"):
		dir.x -= 1
	if Input.is_action_pressed("move_right"):
		dir.x += 1
	if Input.is_action_pressed("move_down"):
		dir.y += 1
	if Input.is_action_pressed("move_up"):
		dir.y -= 1
	
	if dir != Vector2(0,0):
		speed = min(speed+accel*delta, max_speed)
	else:
		speed = max(speed-deccel*delta, 0)
	position += speed * dir.normalized()
	
