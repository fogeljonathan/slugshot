extends Node2D

@onready var last_mod_time_ms:int = Time.get_ticks_msec()
var update_rate_ms = 100

func _process(delta: float) -> void:
	if Time.get_ticks_msec() - last_mod_time_ms > update_rate_ms :
		last_mod_time_ms = Time.get_ticks_msec()
		var mod:float = randf_range(-2,2) * delta
		$PointLight2D.energy = clampf($PointLight2D.energy +mod, .1,.5)
