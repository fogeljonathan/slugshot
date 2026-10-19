extends Node


func _ready() -> void:
	SIGNALS.game_over.connect(_on_game_over)
	SIGNALS.pause.connect(_on_pause)
	SIGNALS.unpause.connect(_on_unpause)

func _on_game_over():
	print("ruh ruh x2 (game.gd)")

func _on_pause():
	self.process_mode = Node.PROCESS_MODE_DISABLED

func _on_unpause():
	self.process_mode = Node.PROCESS_MODE_INHERIT
