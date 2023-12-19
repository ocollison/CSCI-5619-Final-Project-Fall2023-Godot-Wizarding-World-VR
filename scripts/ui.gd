extends CanvasLayer
@onready var tabs = $MarginContainer/TabContainer
@onready var eye_cam = $MarginContainer/TabContainer/AllSeeingEye/Sprite2D

# Called when the node enters the scene tree for the first time.
func _ready():
	pass 


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	if StateManager.big_eye == null:
		tabs.set_tab_hidden(3, true)
		tabs.set_tab_disabled(3, true)
	else:
		tabs.set_tab_hidden(3, false)
		tabs.set_tab_disabled(3, false)
		eye_cam.set_texture(StateManager.big_eye.get_child(0).get_texture())


func _on_follow_pressed():
	StateManager.follow = true

func _on_unfollow_pressed():
	StateManager.follow = false
