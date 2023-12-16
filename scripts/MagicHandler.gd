extends Node3D
@onready var left_fire_magic = $"../LeftController/LeftHand/MagicEmission/FireEmitting"
@onready var right_fire_magic = $"../RightController/RightHand/MagicEmission/FireEmitting"

@onready var left_particles = $"../LeftController/LeftHand/MagicEmission/FireEmitting"
@onready var right_particles = $"../RightController/RightHand/MagicEmission/FireEmitting"
# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	var left_controller_basis = $"../LeftController/LeftHand".global_transform.basis
	var left_direction = -left_controller_basis.z
	left_direction = left_direction.normalized() * 9.8
	left_particles.get_process_material().gravity = left_direction 

#Right Controller tuning
	var right_controller_basis = $"../RightController/RightHand".global_transform.basis
	var right_direction = -right_controller_basis.z
	right_direction = right_direction.normalized() * 9.8
	right_particles.get_process_material().gravity = right_direction 

func _on_left_controller_button_pressed(name):
	if name == "trigger_click":
		left_fire_magic.emitting = true


func _on_right_controller_button_pressed(name):
	if name == "trigger_click":
		right_fire_magic.emitting = true


func _on_left_controller_button_released(name):
	if name == "trigger_click":
		left_fire_magic.emitting = false


func _on_right_controller_button_released(name):
	if name == "trigger_click":
		right_fire_magic.emitting = false
