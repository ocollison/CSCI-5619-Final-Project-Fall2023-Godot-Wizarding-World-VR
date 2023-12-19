extends MeshInstance3D
@export var eye : PackedScene
@onready var main = get_node("/root/Main")
var new_eye = null
var eye_path
# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass


func _on_timer_timeout():
	if eye:
		if new_eye:
			main.remove_child(new_eye)
			new_eye.queue_free()
		new_eye = eye.instantiate()
		if new_eye:
			main.add_child(new_eye)
			StateManager.big_eye = new_eye
			new_eye.set_global_position(self.get_global_position())
	self.get_parent().queue_free()
