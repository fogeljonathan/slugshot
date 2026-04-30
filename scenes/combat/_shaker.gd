extends RigidBody2D

@onready var last_jumping_time_ms:int = Time.get_ticks_msec()
@onready var last_landing_time_ms:int = Time.get_ticks_msec()

@onready var jump_cooldown_ms:int = 1000 + randi_range(-100,100)
@onready var jump_duration_ms:int = 200 + randi_range(-20,20)

@onready var STATUS:String = "waiting"

func _ready() -> void:
	var player_location = get_player_location()

func _process(delta: float) -> void:
	
	if (STATUS == "waiting") and (Time.get_ticks_msec() - last_landing_time_ms > jump_cooldown_ms):
		jump()
		STATUS = "jumping"
		last_landing_time_ms = Time.get_ticks_msec()
		
	elif (STATUS == "jumping") and (Time.get_ticks_msec() - last_jumping_time_ms > jump_duration_ms):
		land()
		STATUS = "waiting"
		last_jumping_time_ms = Time.get_ticks_msec()

func jump():
	print("jump")
	
func land():
	print("land")

func get_player_location() -> Vector2:
	return self.get_parent().get_parent().get_parent().get_child(2).global_position

func _on_body_entered(body: Node) -> void:
	# bullet
	if body is RigidBody2D:
		body.queue_free()
		self.queue_free()
	
	if body is CharacterBody2D:
		print("character")
