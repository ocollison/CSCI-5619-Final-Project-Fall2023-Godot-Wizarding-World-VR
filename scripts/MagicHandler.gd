extends Node3D
@onready var left_lightning_magic = $"../LeftController/LeftHand/MagicEmission/LightningEmitting"
@onready var right_lightning_magic = $"../RightController/RightHand/MagicEmission/LightningEmitting"

@onready var left_particles = $"../LeftController/LeftHand/MagicEmission/LeftFireEmitting"
@onready var right_particles = $"../RightController/RightHand/MagicEmission/RightFireEmitting"

@onready var right_portal_instance = null
@onready var left_portal_instance = null

@onready var left_fire = $"../LeftController/LeftHand/MagicEmission/LeftFireSpell/Flames"
@onready var right_fire = $"../RightController/RightHand/MagicEmission/RightFireSpell/Flames"

@onready var left_ice = $"../LeftController/LeftHand/MagicEmission/left_ice_spell"
@onready var right_ice = $"../RightController/RightHand/MagicEmission/right_ice_spell"

@onready var spell 

@onready var main = $"../.."

@onready var ice_spell
@export var projectile : PackedScene
@export var projectile_speed : float = 15.0

@onready var lefty = $"../LeftController/LeftHand"
@onready var l_marker = $"../LeftController/LeftHand/Marker3D"
@onready var righty = $"../RightController/RightHand"
@onready var r_marker =$"../RightController/RightHand/Marker3D"
var left_direction
var right_direction

func _ready():
	StateManager.state_changed.connect(spell_casted)
	
# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	
	#particle tuning so they emit the right way
	var left_controller_basis = $"../LeftController/LeftHand".global_transform.basis
	left_direction = -left_controller_basis.z
	left_direction = left_direction.normalized() * 9.8
	
	left_particles.get_process_material().gravity = left_direction 
	left_lightning_magic.get_process_material().gravity = left_direction 
	left_fire.get_process_material().gravity = left_direction 
#Right Controller tuning
	var right_controller_basis = $"../RightController/RightHand".global_transform.basis
	right_direction = -right_controller_basis.z
	right_direction = right_direction.normalized() * 9.8
	
	
	right_particles.get_process_material().gravity = right_direction 
	right_lightning_magic.get_process_material().gravity = right_direction 
	right_fire.get_process_material().gravity = right_direction 
func spell_casted():
	var spell = StateManager.spell
	set_spell_state(spell)



func set_spell_state(spell):
	for state in get_tree().get_nodes_in_group("State"):
		var state_name = str(state.name).to_lower()
		if state_name.contains(str(spell)):
			state.emitting = true
			#print(spell + " does equal to " + state_name)
		else:
			state.emitting = false
			#print(spell + " does not match up to " + state_name)

func _on_left_controller_button_pressed(name):
	if name == "trigger_click":
		var state = StateManager.spell
		match state:
			"fire":
				left_fire.emitting = true
			"ice":
				pass
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
				right_fire.emitting = true
			"ice":
				pass
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
				left_fire.emitting = false
			"ice":
				ice_projectile(l_marker)
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
				right_fire.emitting = false
			"ice":
				ice_projectile(r_marker)
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

func ice_projectile(marker):
	if projectile:
		var new_projectile : RigidBody3D = projectile.instantiate()
		if new_projectile:
			new_projectile.set_as_top_level(true)
			add_child(new_projectile)
			new_projectile.transform = marker.global_transform
			new_projectile.linear_velocity = new_projectile.transform.basis.z * projectile_speed
