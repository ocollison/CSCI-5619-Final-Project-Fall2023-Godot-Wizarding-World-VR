extends Node2D

var drawing = false
#@onready var line = $Polygon2D/Line2D
#@onready var tabs = $".."
@onready var lines = $Lines
var pressed := false
var current_line: Line2D

func _ready() -> void:
	#lines.default_color = Color.BLACK
	#Input.warp_mouse(Vector2(0, 0))
	#add_child(lines)
	pass

func _input(event):
	if event is InputEventMouseButton and event.pressed and drawing:
		pressed = event.pressed
		
		if pressed:
			current_line = Line2D.new()
			lines.add_child(current_line)

	if event is InputEventMouseMotion && pressed:
		current_line.add_point(event.position) 

func _process(delta):
	#lines.position = get_global_mouse_position()
	pass

func _on_clear_pressed():
	current_line.clear_points()


func _on_cast_spell_pressed():
	if drawing == false:
		drawing = true
		print("true")
	else:
		drawing = false
		print("false")


func _on_other_tab_selected(tab):
	pass # Replace with function body.
