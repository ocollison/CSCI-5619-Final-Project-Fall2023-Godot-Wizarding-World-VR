extends Node3D
var speed = 2.5
var range = 10
var direction = 3 

# Called when the node enters the scene tree for the first time.
func _ready():
	pass


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	if $Ice.visible == false:
		$stars.emitting = false
	else:
		$stars.emitting = true
	#self.global_position += get_parent().global_transform.basis.z * Vector3(-delta*3, -delta*3, -delta*3)
	var lefty = $"../XROrigin3D/LeftController/LeftHand"
	var left_direction
	var left_controller_basis = lefty.global_transform.basis
	
	left_direction = -left_controller_basis.z
	left_direction = left_direction.normalized() * 9.8
	
	var movement = speed * delta * direction
	translate(Vector3(movement, 0, 0))
func move(direction, speed):
	self.global_position += direction *speed
		
