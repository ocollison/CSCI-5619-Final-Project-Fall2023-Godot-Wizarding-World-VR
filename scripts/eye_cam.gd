extends Sprite3D
@onready var player = %XROrigin3D

# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	self.look_at(player.get_global_position())


func _on_right_controller_button_released(name):
	if name == "trigger_click" and !%Menu.is_visible() and StateManager.spell == "vision":
		if StateManager.big_eye != null:
			self.set_texture(StateManager.big_eye.get_child(0).get_texture())
