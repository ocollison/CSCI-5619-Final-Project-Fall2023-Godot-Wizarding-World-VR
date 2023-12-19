extends MeshInstance3D
@onready var player = get_node("/root/Main/XROrigin3D/")
@onready var camera = $SubViewport/Camera3D
# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	if StateManager.follow == true:
		self.look_at(player.get_global_position())
		camera.look_at(player.get_global_position())
