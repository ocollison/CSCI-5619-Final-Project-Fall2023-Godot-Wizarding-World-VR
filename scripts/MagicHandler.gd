extends Node3D
@onready var left_lightning_magic = $"../LeftController/LeftHand/MagicEmission/LightningEmitting"
@onready var right_lightning_magic = $"../RightController/RightHand/MagicEmission/LightningEmitting"

@onready var left_particles = $"../LeftController/LeftHand/MagicEmission/LeftFireEmitting"
@onready var right_particles = $"../RightController/RightHand/MagicEmission/RightFireEmitting"


@onready var red_pos = $"../../SpawnRed"
@onready var blue_pos = $"../../SpawnBlue"
@onready var green_pos = $"../../SpawnGreen"
@onready var spawns = [red_pos, green_pos, blue_pos]
@onready var spawn_index = 0
@export var spawn_selector : PackedScene
@onready var new_spawn_selector = null

@onready var left_fire = $"../LeftController/LeftHand/MagicEmission/LeftFireSpell/Flames"
@onready var right_fire = $"../RightController/RightHand/MagicEmission/RightFireSpell/Flames"

@onready var menu =  %Menu

@onready var main = $"../.."
@onready var player = $".."

@onready var ice_spell
@export var projectile : PackedScene
@export var projectile_speed : float = 15.0
@onready var l_marker = $"../LeftController/LeftHand/Marker3D"
@onready var r_marker =$"../RightController/RightHand/Marker3D"

@onready var lefty = $"../LeftController/LeftHand"
@onready var righty = $"../RightController/RightHand"

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
	if name == "trigger_click" and !menu.is_visible():
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
	if name == "trigger_click" and !menu.is_visible():
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
				make_portal_selector()
			"normal":
				pass

func _on_left_controller_button_released(name):
	if name == "trigger_click" and !menu.is_visible():
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
				#make_left_portal()
				make_portal()
			"normal":
				pass
				
				
func _on_right_controller_button_released(name):
	if name == "trigger_click" and !menu.is_visible():
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
				delete_portal_selector()
				pass
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
			
func make_portal():
	if spawn_index >= spawns.size():
		spawn_index = 0
	spawns[spawn_index].set_global_position(self.get_global_position())
	spawns[spawn_index].visible = true
	spawn_index += 1
	
func make_portal_selector():
	if spawn_selector:
		new_spawn_selector = spawn_selector.instantiate()
		if new_spawn_selector:
			player.add_child(new_spawn_selector)
			new_spawn_selector.set_position(Vector3(0, 0.507, -0.361))
	
func delete_portal_selector():
	if new_spawn_selector:
		if new_spawn_selector.color:
			var color = new_spawn_selector.color
			teleport(color)
		player.remove_child(new_spawn_selector)
		new_spawn_selector.queue_free()

func teleport(color):
	for spawn in spawns:
		if spawn.name.contains(color):
			player.set_global_position(spawn.get_global_position())

