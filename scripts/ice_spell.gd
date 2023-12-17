extends Node3D


# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	self.global_position += get_parent().global_transform.basis.z * Vector3(-delta*3, -delta*3, -delta*3)
