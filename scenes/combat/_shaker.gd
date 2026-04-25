extends RigidBody2D

func _on_body_entered(body: Node) -> void:
	# bullet
	if body is RigidBody2D:
		body.queue_free()
		self.queue_free()
	
	if body is CharacterBody2D:
		print("character")
