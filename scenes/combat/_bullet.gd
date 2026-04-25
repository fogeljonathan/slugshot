extends RigidBody2D

@onready var spawn_time_ms:int = Time.get_ticks_msec()
var life_time_ms:int = 10000

func _process(delta: float) -> void:
	if Time.get_ticks_msec() - spawn_time_ms > life_time_ms:
		self.queue_free()
