extends Node

signal state_changed
signal arcane
var spell = "normal"
var num = 1
@onready var error = $"../ErrorLabel"
var big_eye = null
@onready var follow = false
@onready var spell_label = $"../SpellLabel"
var drawing = true
var drawings = []

# Called when the node enters the scene tree for the first time.
func _ready():
	pass


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
	var special_words = ["fire", "ice", "teleport", "vision", "grab"]
	
	for word in special_words:
		if finalResults.find(word) != -1:
			self.spell = word
			set_spell(word)
			spell_activation_cue(spell)
			$"../SpellLabel".text = str("You've casted the " + spell + " spell!")
			spell_label.visible = true
			#print(spell_label.get_text())
			error.visible = false
			return
		
	print("No special ability found in string")
	spell_label.visible = false
	error.visible = true
	
func spell_activation_cue(spell):
	if spell == "fire":
		var audio = load("res://audio/Fire.mp3")
		$"../SpellCue".play()
	if spell == "ice":
		var audio = load("res://audio/Ice.mp3")
		$"../SpellCue".play()
	if spell == "teleport":
		var audio = load("res://audio/Teleportation.mp3")
		$"../SpellCue".play()
	if spell == "vision":
		pass
	if spell == "grab":
		pass
