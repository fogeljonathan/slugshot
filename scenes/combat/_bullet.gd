extends RigidBody2D

var goop_spawn_time_ms = 500
@onready var last_gooped_time = 0

@onready var spawn_time_ms:int = Time.get_ticks_msec()
var life_time_ms:int = 10000

func _process(delta: float) -> void:
	if Time.get_ticks_msec() - spawn_time_ms > life_time_ms:
		SIGNALS.emit_signal("spawn_goop", self.global_position, 2)
		self.queue_free()
	
	if Time.get_ticks_msec() - last_gooped_time > goop_spawn_time_ms:
			last_gooped_time = Time.get_ticks_msec()
			SIGNALS.emit_signal("spawn_goop", self.global_position, 1)
			

	
