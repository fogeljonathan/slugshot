extends Node

@onready var main_bus = %AudioStreamPlayer

func play_sound(stream : AudioStream):
	var instance = AudioStreamPlayer.new()
	instance.stream = stream
	instance.finished.connect(remove_node.bind(instance))
	add_child(instance)
	instance.play()

func remove_node(instance : AudioStream):
	instance.queue_free()
	
