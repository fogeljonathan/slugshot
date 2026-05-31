extends RigidBody2D

@onready var last_jumping_time_ms:int = -INF
@onready var last_landing_time_ms:int = Time.get_ticks_msec()

@onready var jump_cooldown_ms:float = 1000 + randi_range(-100,100)
@onready var jump_duration_ms:float = 2000 + randi_range(-500,500)

@onready var anim_fps = randi_range(4,8)

@onready var jump_vel:float = 20 + randf_range(-5,5)

@onready var STATUS:String = "idle"

var vel_x_tween:Tween
var vel_y_tween:Tween

func _ready() -> void:
	$AnimatedSprite2D.get_sprite_frames().set_animation_speed("idle", anim_fps);
	$AnimatedSprite2D.get_sprite_frames().set_animation_speed("jump", anim_fps);
	$AnimatedSprite2D.play("idle")

func _process(delta: float) -> void:
	var what_time_is_it = Time.get_ticks_msec()
	
	if (STATUS == "idle") and (what_time_is_it - last_landing_time_ms > jump_cooldown_ms):
		jump()
		STATUS = "jumping"
		last_jumping_time_ms = what_time_is_it
		
	elif (STATUS == "jumping") and (what_time_is_it - last_jumping_time_ms > jump_duration_ms):
		land()
		STATUS = "idle"
		last_landing_time_ms = what_time_is_it

func jump():
	var player_location = get_player_location()
	var move_to = self.global_position + (player_location - self.global_position).normalized() * jump_vel
	
	if vel_x_tween and vel_x_tween.is_running():
		vel_x_tween.kill()
	if vel_y_tween and vel_y_tween.is_running():
		vel_y_tween.kill()
		
	vel_x_tween = create_tween().set_ease(Tween.EASE_OUT).set_trans(Tween.TRANS_LINEAR)
	vel_x_tween.tween_property(self, "global_position:x", move_to.x, jump_duration_ms/1000 )
	
	
	vel_y_tween = create_tween().set_ease(Tween.EASE_OUT).set_trans(Tween.TRANS_BACK)
	vel_y_tween.tween_property(self, "global_position:y", move_to.y, jump_duration_ms/1000 )
	$AnimatedSprite2D.play("jump")
	
func land():
	$AnimatedSprite2D.play("idle")

func get_player_location() -> Vector2:
	return self.get_parent().get_parent().get_parent().get_child(2).global_position

func _on_body_entered(body: Node) -> void:
	# bullet
	if body is RigidBody2D:
		SIGNALS.emit_signal("bullet_hits_shaker")
		body.queue_free()
		brb_killin_ma_self()
	
	#player
	if body is CharacterBody2D:
		SIGNALS.emit_signal("shaker_hits_player")
		brb_killin_ma_self()

func brb_killin_ma_self():
	self.queue_free()
