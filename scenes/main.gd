extends Node

@onready var paused = false
@onready var gameovered = false

func _ready() -> void:
	SIGNALS.game_over.connect(_on_game_over)
	SIGNALS.pause.connect(_on_pause)
	SIGNALS.unpause.connect(_on_unpause)

func _process(delta: float) -> void:
	if Input.is_action_just_pressed("pause"):
		if paused:
			SIGNALS.emit_signal("unpause")
		else:
			SIGNALS.emit_signal("pause")

func _on_pause():
	paused = true
	$SubViewportContainer/UI/pausemenu.visible = true
	
func _on_unpause():
	paused = false
	$SubViewportContainer/UI/pausemenu.visible = false

func _on_game_over():
	print("ruh roh... need to do this still.")
