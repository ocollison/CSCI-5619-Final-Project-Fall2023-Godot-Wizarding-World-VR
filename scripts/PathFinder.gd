extends Node
#@onready var spawn_red = $"../SpawnRed".get_path()
#@onready var spawn_blue = $"../SpawnBlue".get_path()
#@onready var spawn_green = $"../SpawnGreen".get_path()
#@onready var right_hand_collison = $"../XROrigin3D/RightController/RightHand/Collisions/Area3D".get_path()
#@onready var object = $"../XROrigin3D/XRCamera3D/SpawnSelector"
# Called when the node enters the scene tree for the first time.
func _ready():
	pass


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass


func _on_left_controller_button_pressed(name):
	pass
	#if name == "ax_button":
		#object.global_translate(0.1, 0, 0)
		#print(object.get_global_position())
	#if name == "by_button":
		#object.global_translate(-0.1, 0, 0)
		#print(object.get_global_position())
	#if name == "trigger_click":
		#object.global_translate(0, 0, -0.1)
		#print(object.get_global_position())


func _on_right_controller_button_pressed(name):
	pass
	#if name == "ax_button":
		#object.global_translate(0, 0.1, 0)
		#print(object.get_global_position())
	#if name == "by_button":
		#object.global_translate(0, -0.1, 0)
		#print(object.get_global_position())
	#if name == "trigger_click":
		#object.global_translate(0, 0, 0.1)
		#print(object.get_global_position())

