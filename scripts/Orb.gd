extends MeshInstance3D
@onready var view = $"../SubViewport"

# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass
	
func set_view_texture(texture):
	#view.set_texture(texture)
	var mat = StandardMaterial3D.new()
	var tex = texture
	mat.albedo_texture = tex
	self.set_surface_override_material(0, mat)
