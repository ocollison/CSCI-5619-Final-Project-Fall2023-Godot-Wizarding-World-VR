extends Node3D


# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	if $Flames.emitting == true:
		$Smoke.emitting = true
	else:
		$Smoke.emitting = false
	#self.global_position += get_parent().global_transform.basis.z * Vector3(-delta*3, -delta*3, -delta*3)
	#$Flames.process_material.gravity = get_parent().global_transform.basis.z * Vector3(-delta*3, -delta*3, -delta*3)
	#$Smoke.process_material.gravity = get_parent().global_transform.basis.z * Vector3(-delta*3, -delta*3, -delta*3)
	
