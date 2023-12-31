extends MeshInstance3D

var grabbed_object: RigidBody3D = null
var pointed_object: RigidBody3D = null
var previous_transform: Transform3D
var old_dist = 1 

# Called when the node enters the scene tree for the first time.
func _ready():
	pass


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	if StateManager.spell == "grab" and %Menu.visible == false:
		self.visible = true
		self.scale.z = 100
		self.position.z = -50

		var start_point = get_parent().global_position
		var end_point = get_parent().global_transform * Vector3(0, 0, -100)

		var query = PhysicsRayQueryParameters3D.create(start_point, end_point)
		query.collide_with_bodies = true
		
		var result = get_world_3d().direct_space_state.intersect_ray(query)

		if !result.is_empty():
			var collision_distance = result["position"].distance_to(start_point)
			self.scale.z = collision_distance
			self.position.z = -collision_distance / 2

			var objects = get_tree().get_nodes_in_group("interactable")
			for object in objects:
				#print(object)
				if result["collider_id"] == object.get_instance_id():
					self.pointed_object = object
				else:
					self.pointed_object = null

		else:
			self.scale.z = 100
			self.position.z = -50
			self.pointed_object = null
			
		if self.grabbed_object:
			
			self.grabbed_object.transform = $%RightController.global_transform * self.previous_transform.affine_inverse() * self.grabbed_object.transform
			
			for grabby in grabbed_object.get_children():
				grabby.scale *=  ($%LeftController.global_position.distance_to($%RightController.global_position))/old_dist
		old_dist = $%LeftController.global_position.distance_to($%RightController.global_position)
		self.previous_transform = $%RightController.global_transform
	else:
		self.visible = false

func _on_right_controller_button_pressed(button_name:String):
	if button_name == 'trigger_click':
		if pointed_object != null:
			print("grabbed")
			self.grabbed_object = self.pointed_object
			# $%RightController.add_child(self.pointed_object)


func _on_right_controller_button_released(button_name: String) -> void:
	if button_name != 'trigger_click' || self.grabbed_object == null:
		return
	self.grabbed_object.freeze = false
	self.grabbed_object.linear_velocity = Vector3(0, -0.1, 0)
	self.grabbed_object.angular_velocity = Vector3.ZERO
	self.grabbed_object = null

