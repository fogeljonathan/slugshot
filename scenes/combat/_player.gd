extends CharacterBody2D

var movement_speed:float = 1.
var friction_term:float = 10.

var last_shot_time_ms:int = 0
@export var shot_delay_ms:float = .2 * 1000
@export var bullet_speed:float = 500

func _process(delta) -> void:
	# moving
	var dir:Vector2 = Vector2(0, 0)
	dir += Vector2(1, 0) * int(Input.is_action_pressed("move_right"))
	dir += Vector2(-1, 0) * int(Input.is_action_pressed("move_left"))
	dir += Vector2(0, 1) * int(Input.is_action_pressed("move_down"))
	dir += Vector2(0, -1) * int(Input.is_action_pressed("move_up"))
	if dir != Vector2(0,0):
		velocity = dir.normalized()
	else:
		velocity *= (1- (delta*friction_term))
	
	# bouncing
	var collision = move_and_collide(velocity)
	if collision:
		velocity = 0.5 * velocity.bounce(collision.get_normal())
	
	# aiming
	$Crosshair/Line2D.position = get_global_mouse_position()
	$sprite_gun.look_at(get_global_mouse_position())

	# shooting
	if Input.is_action_pressed("shoot") :
		if validate_shot() :
			SIGNALS.emit_signal("spawn_bullet", $sprite_gun/end_of_gun.global_position, $sprite_gun.global_rotation, bullet_speed)
			last_shot_time_ms = Time.get_ticks_msec()

func validate_shot() -> bool:
	if Time.get_ticks_msec() - last_shot_time_ms > shot_delay_ms:
		return true
	return false
