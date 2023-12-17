extends Node3D
@onready var left_lightning_magic = $"../LeftController/LeftHand/MagicEmission/LightningEmitting"
@onready var right_lightning_magic = $"../RightController/RightHand/MagicEmission/LightningEmitting"

@onready var left_particles = $"../LeftController/LeftHand/MagicEmission/LeftFireEmitting"
@onready var right_particles = $"../RightController/RightHand/MagicEmission/RightFireEmitting"

@onready var right_portal_instance = null
@onready var left_portal_instance = null

@onready var spell 

@onready var main = $"../.."


func _ready():
	
	StateManager.state_changed.connect(spell_casted)
	
# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	
	#particle tuning so they emit the right way
	var left_controller_basis = $"../LeftController/LeftHand".global_transform.basis
	var left_direction = -left_controller_basis.z
	left_direction = left_direction.normalized() * 9.8
	left_particles.get_process_material().gravity = left_direction 
	left_lightning_magic.get_process_material().gravity = left_direction 
#Right Controller tuning
	var right_controller_basis = $"../RightController/RightHand".global_transform.basis
	var right_direction = -right_controller_basis.z
	right_direction = right_direction.normalized() * 9.8
	right_particles.get_process_material().gravity = right_direction 
	right_lightning_magic.get_process_material().gravity = right_direction 

func spell_casted():
	var spell = StateManager.spell
	set_spell_state(spell)



func set_spell_state(spell):
	for state in get_tree().get_nodes_in_group("State"):
		var state_name = str(state.name).to_lower()
		if state_name.contains(str(spell)):
			state.emitting = true
		else:
			state.emitting = false

func _on_left_controller_button_pressed(name):
	if name == "trigger_click":
		print("REAL " + StateManager.spell)
		var state = StateManager.spell
		match state:
			"fire":
				left_particles.emitting = true
			"lightning":
				left_lightning_magic.emitting = true
			"grab":
				pass
			"shoot":
				pass
			"teleport":
				pass
			"normal":
				pass


func _on_right_controller_button_pressed(name):
	if name == "trigger_click":
		var state = StateManager.spell
		match state:
			"fire":
				right_particles.emitting = true
			"lightning":
				right_lightning_magic.emitting = true
			"grab":
				pass
			"shoot":
				pass
			"teleport":
				pass
			"normal":
				pass

func _on_left_controller_button_released(name):
	if name == "trigger_click":
		var state = StateManager.spell
		match state:
			"fire":
				left_particles.emitting = false
			"lightning":
				left_lightning_magic.emitting = false
			"grab":
				pass
			"shoot":
				pass
			"teleport":
				if left_portal_instance != null:
					main.remove_child(left_portal_instance)
					left_portal_instance.queue_free()
					
				var portal
				portal = load("res://scenes/left_portal.tscn")
				
				var translation = global_transform.basis.z * -5  
				
				left_portal_instance = portal.instantiate()
				main.add_child(left_portal_instance)
				
				left_portal_instance.global_transform.origin = translation
			"normal":
				pass

func _on_right_controller_button_released(name):
	if name == "trigger_click":
		var state = StateManager.spell
		match state:
			"fire":
				right_particles.emitting = false
			"lightning":
				right_lightning_magic.emitting = false
			"grab":
				pass
			"shoot":
				pass
			"teleport":
				if right_portal_instance != null:
					main.remove_child(right_portal_instance)
					right_portal_instance.queue_free()
					
				var portal
				portal = load("res://scenes/right_portal.tscn")
				
				var translation = global_transform.basis.z * -5  
				
				right_portal_instance = portal.instantiate()
				main.add_child(right_portal_instance)
				
				right_portal_instance.global_transform.origin = translation
			"normal":
				pass

func create_portal():
	pass
