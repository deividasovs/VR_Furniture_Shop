extends CSGCombiner

# references the light that is used for the lamp
# IMPORTANT: If you rename your light, you will need to change this line.
onready var lamp_light = $LampLight
onready var lamp_sound = $LampSound

# Turned off by default
func _ready():
	lamp_light.visible = false

# Turns the light on
func turn_on():
	lamp_sound.play()
	lamp_light.visible = true

# Turns the light off
func turn_off():
	lamp_sound.play()
	lamp_light.visible = false

func _on_Area_body_entered(body):
	if(body.name == "FPPlayerLocomotion"):
		turn_on()
	
func _on_Area_body_exited(body):
	if(body.name == "FPPlayerLocomotion"):
		turn_off()
