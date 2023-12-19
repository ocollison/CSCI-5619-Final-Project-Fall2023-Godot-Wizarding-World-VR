extends Node3D
@onready var player_collison = get_node("/root/Main/XROrigin3D/RightController/RightHand/Collisions/Area3D")
@onready var read_collison = false
@onready var red = get_node("/root/Main/SpawnRed")
@onready var blue = get_node("/root/Main/SpawnBlue")
@onready var green = get_node("/root/Main/SpawnGreen")
var color = null
# Called when the node enters the scene tree for the first time.
func _ready():
	if red.is_visible() == false:
		get_child(0).visible = false
		get_child(0).get_child(0).monitoring = false
		get_child(0).get_child(0).monitorable = false
	else:
		get_child(0).visible = true
		get_child(0).get_child(0).monitoring = true
		get_child(0).get_child(0).monitorable = true
		
	if blue.is_visible() == false:
		get_child(1).visible = false
		get_child(1).get_child(0).monitoring = false
		get_child(1).get_child(0).monitorable = false
	else:
		get_child(1).visible = true
		get_child(1).get_child(0).monitoring = true
		get_child(1).get_child(0).monitorable = true
		
	if green.is_visible() == false:
		get_child(2).visible = false
		get_child(2).get_child(0).monitoring = false
		get_child(2).get_child(0).monitorable = false
	else:
		get_child(2).visible = true
		get_child(2).get_child(0).monitoring = true
		get_child(2).get_child(0).monitorable = true


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass
	
func _physics_process(delta):
	for box in self.get_children():
		if box.get_child(0).overlaps_area(player_collison):
			box.get_child(1).visible = true
			color = box.name
		else:
			box.get_child(1).visible = false
