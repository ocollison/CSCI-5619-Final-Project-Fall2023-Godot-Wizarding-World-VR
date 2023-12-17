extends Node

signal state_changed
var spell = "normal"
var num = 1
@onready var error = $"../ErrorLabel"

# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass

func set_spell(new_spell):
	spell = new_spell
	StateManager.spell = new_spell
	StateManager.state_changed.emit()

func clean_text(json_text):
	var regex = RegEx.new()
	regex.compile("""\"text\"\\s*:\\s*\"([^\"]*)\"""")
	
	var result = regex.search(json_text)
	if result:
		# Return first capture group 
		return result.get_string(1) 
	else:
		return ""

func _on_speech_recognizer_on_final_result(finalResults):
	finalResults = clean_text(finalResults)
	var special_words = ["fire", "ice", "teleport", "shoot", "grab"]
	
	for word in special_words:
		if finalResults.find(word) != -1:
			self.spell = word
			set_spell(word)
			error.visible = false
			return
		
	print("No special ability found in string")
	error.visible = true
