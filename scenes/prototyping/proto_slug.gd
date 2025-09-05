extends RigidBody2D

@export var lifespan_ms:int = 1000

var spawn_time_ms:int

func _ready() -> void:
	spawn_time_ms = Time.get_ticks_msec()
	
func _process(delta: float) -> void:
	if Time.get_ticks_msec() - spawn_time_ms >= lifespan_ms :
		self.queue_free()
