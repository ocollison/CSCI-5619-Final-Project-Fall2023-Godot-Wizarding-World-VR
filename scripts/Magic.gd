extends XRController3D

# Called when the node enters the scene tree for the first time.
func _ready():
	pass


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	var projectile = get_node("Node3D")
	var collision_area = get_node("Node3D/Area3D")
	if collision_area != null:
		var collidables = get_tree().get_nodes_in_group("collidable")
		for collidable in collidables:
			var collidable_body = collidable as RigidBody3D
			if collision_area.overlaps_body(collidable_body):
				collidable_body.queue_free()
				projectile.queue_free()


func _on_button_pressed(button_name:String):
	if button_name == 'trigger_click':
		var scene = preload("res://scenes/ice_spell.tscn")
		var instance = scene.instantiate()
		self.add_child(instance)
		await get_tree().create_timer(5.0).timeout
		if instance != null:
			instance.queue_free()


	