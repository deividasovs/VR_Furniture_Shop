extends Spatial

# references the light that is used for the lamp
# IMPORTANT: If you rename your light, you will need to change this line.
onready var anim_player = $UIPopUpAnimPlayer

# Turned off by default
func _ready():
	anim_player.playback_speed =  1
	anim_player.stop()
	
func show_popup():
	anim_player.playback_speed =  1
	anim_player.play("MoveExitUIUp")
	
func close_popup():
	anim_player.playback_speed = -1
	anim_player.play("MoveExitUIUp")
	


func _on_Area_body_entered(body):
	if(body.name == "FPPlayerLocomotion" || body.name == "VRPlayer"):
		show_popup()

func _on_Area_body_exited(body):
	if(body.name == "FPPlayerLocomotion" || body.name == "VRPlayer"):
		close_popup()
	
