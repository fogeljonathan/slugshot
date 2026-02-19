extends CharacterBody2D

# movement
var movement_speed:float = 1.
var friction_term:float = 10.

# gun and bullet spawning
var last_shot_time_ms:int = 0
@export var shot_delay_ms:float = .2 * 1000
@export var bullet_speed:float = 500
var tween_muzzle_flash : Tween

# state machine
enum DIR {LEFT, RIGHT}
enum MOTION {MOVING, IDLE}
@onready var state_dir:DIR = DIR.RIGHT
@onready var state_motion:MOTION = MOTION.IDLE
var inputdir = Vector2(0,0)

func _ready() -> void:
	if !SIGNALS.is_connected("spawn_muzzle_flash", _do_muzzle_flash):
		SIGNALS.spawn_muzzle_flash.connect(_do_muzzle_flash)
	
func _input(event: InputEvent) -> void:
	inputdir = Vector2(0, 0)
	# set sprite state
	if Input.is_action_pressed("move_right"):
		state_dir = DIR.RIGHT
		inputdir += Vector2(1, 0)
	elif Input.is_action_pressed("move_left"):
		state_dir = DIR.LEFT
		inputdir += Vector2(-1, 0)
	
	if Input.is_action_pressed("move_down"):
		inputdir += Vector2(0, 1)
	elif Input.is_action_pressed("move_up"):
		inputdir += Vector2(0, -1)
	# are we telling it to be moving 
	if inputdir == Vector2(0,0):
		state_motion = MOTION.IDLE
	else:
		state_motion = MOTION.MOVING
	
func _process(delta) -> void:
	# l/r sprite flipping
	if state_dir == DIR.LEFT:
		$slug_animation.scale = Vector2(-1,1)
	else:
		$slug_animation.scale = Vector2(1,1)
	# animation handling
	if state_motion == MOTION.IDLE:
		$slug_animation.animation = "idle_right"
	if state_motion == MOTION.MOVING:
		$slug_animation.animation = "moving_right"
	# moving
	if inputdir != Vector2(0,0):
		velocity = inputdir.normalized()
	else:
		velocity *= (1- (delta*friction_term))
	var collision = move_and_collide(velocity)
	if collision:
		velocity = 0.5 * velocity.bounce(collision.get_normal())
	# aiming
	$Crosshair/Line2D.position = get_global_mouse_position()
	$sprite_gun.look_at(get_global_mouse_position())
	# shooting
	if Input.is_action_pressed("shoot") :
		if validate_shot():
			# shoot!
			SIGNALS.emit_signal("spawn_bullet", $sprite_gun/end_of_gun.global_position, $sprite_gun.global_rotation, bullet_speed)
			last_shot_time_ms = Time.get_ticks_msec()
	# extra
	if $debug.visible:
		$debug.text = str(state_motion)+str(state_dir)
	
func _do_muzzle_flash() -> void:
	if tween_muzzle_flash && tween_muzzle_flash.is_running():
		tween_muzzle_flash.kill()
	$sprite_gun/end_of_gun/muzzle_flash.energy = .25
	tween_muzzle_flash = create_tween().set_ease(Tween.EASE_OUT).set_trans(Tween.TRANS_SINE)
	tween_muzzle_flash.tween_property($sprite_gun/end_of_gun/muzzle_flash, "energy", 0, .1)
	
func validate_shot() -> bool:
	if Time.get_ticks_msec() - last_shot_time_ms > shot_delay_ms:
		return true
	return false
