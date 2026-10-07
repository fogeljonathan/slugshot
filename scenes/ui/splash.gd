extends Control

var logo_velocity:Vector2 = Vector2(0,0)
var opacity_tween: Tween

func _ready() -> void:
	logo_velocity = Vector2(randi_range(-50, 50), randi_range(-50, 50))
	$logo.visible = true
	
	opacity_tween = create_tween().set_ease(Tween.EASE_IN).set_trans(Tween.TRANS_SINE)
	opacity_tween.tween_property($faderthingy, "self_modulate:a", 0, .25)
	
	await get_tree().create_timer(1).timeout
	
	opacity_tween = create_tween().set_ease(Tween.EASE_IN).set_trans(Tween.TRANS_SINE)
	opacity_tween.tween_property($faderthingy, "self_modulate:a", 1, .25)
	
	await get_tree().create_timer(.5).timeout
	
	get_tree().change_scene_to_file("res://scenes/main.tscn")
