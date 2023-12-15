extends TabBar

var drawing = false
@onready var line = $Polygon2D/Line2D
@onready var tabs = $".."


func _ready() -> void:
	line.default_color = Color.BLACK
	Input.warp_mouse(Vector2(0, 0))

func _input(event):
	if tabs.get_current_tab() == 2:
		if event is InputEventMouseButton:
			drawing = event.pressed
			
		if drawing and event is InputEventMouseMotion:
			line.add_point(event.position)
	else:
		line.clear_points()

func _on_clear_pressed():
	line.clear_points()


func _on_cast_spell_pressed():
	pass # Replace with function body.


func _on_other_tab_selected(tab):
	pass # Replace with function body.
