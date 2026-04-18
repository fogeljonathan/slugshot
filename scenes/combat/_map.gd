extends Node2D

@export var _bullet : PackedScene
@export var _shaker : PackedScene
@export var shaker_spawn_delay_ms = 1000
var time_since_shaker_spawn_ms = 0
var game_time = 0

func _ready() -> void:
	Input.set_mouse_mode(Input.MOUSE_MODE_HIDDEN)
	if !SIGNALS.is_connected("spawn_bullet", _on_spawn_bullet):
		SIGNALS.spawn_bullet.connect(_on_spawn_bullet)
	
func _process(delta: float) -> void:
	if Time.get_ticks_msec() - time_since_shaker_spawn_ms > shaker_spawn_delay_ms:
			time_since_shaker_spawn_ms = Time.get_ticks_msec()
			spawn_shaker(1)

func _on_spawn_bullet(spawn_position: Vector2, spawn_rotation: float, spawn_speed: float) -> void:
	var b = _bullet.instantiate()
	b.position = spawn_position
	b.rotation = spawn_rotation
	b.linear_velocity = Vector2(spawn_speed * cos(spawn_rotation), spawn_speed * sin(spawn_rotation))
	get_node("bullets").add_child(b)
	SIGNALS.spawn_muzzle_flash.emit()

func spawn_shaker(count):
	for n in range(count): 
		var s = _shaker.instantiate()
		s.position = Vector2(randi_range(0, get_viewport().size.x), randi_range(0, get_viewport().size.y))
		get_node("shakers").add_child(s)
		
