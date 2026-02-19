extends Node2D

@export var bullet : PackedScene

func _ready() -> void:
	hide_mouse()
	if !SIGNALS.is_connected("spawn_bullet", _on_spawn_bullet):
		SIGNALS.spawn_bullet.connect(_on_spawn_bullet)

func hide_mouse():
	Input.set_mouse_mode(Input.MOUSE_MODE_HIDDEN)

func _on_spawn_bullet(spawn_position: Vector2, spawn_rotation: float, spawn_speed: float) -> void:
	SIGNALS.do_muzzle_flash.emit()
	var b = bullet.instantiate()
	print("AAAA")
	get_node("bullets").add_child(b)
	b.position = spawn_position
	b.rotation = spawn_rotation
	b.linear_velocity = Vector2(spawn_speed * cos(spawn_rotation), spawn_speed * sin(spawn_rotation))
