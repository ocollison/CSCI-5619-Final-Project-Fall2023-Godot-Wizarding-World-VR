extends MeshInstance3D
@onready var player = $"../XROrigin3D"
@onready var player_collison = $"../XROrigin3D/Node3D/PlayerCollison"
@onready var marker = $"../SpawnPoint"
@onready var collison = $Area3D
# Called when the node enters the scene tree for the first time.
func _ready():
	pass


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass

func _physics_process(delta):
	if collison.overlaps_area(player_collison):
		player.global_transform = marker.global_transform
