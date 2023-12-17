extends GPUParticles3D


# Called when the node enters the scene tree for the first time.
func _ready():
	#get_matching_spell()
	pass

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass

#Function that matches the magic state user is in with the actual spell to be emitted
func get_matching_spell():
	var name = self.name
	for spell in get_tree().get_nodes_in_group("Spell"):
		if spell.name.begins_with(name):
			var path = spell.get_path() 
			print(path)
			return path
	return ""


