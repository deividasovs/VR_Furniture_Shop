extends StaticBody

onready var anim_player = $AnimationPlayer
onready var sound_player = $AudioStreamPlayer3D
var door_open = false

# Anim not playing by default
func _ready():
	door_open = false
	anim_player.stop()

func open_door():
	# Only animate if the animation hasn't played yet
	if !door_open:
		sound_player.play()
		anim_player.play("DoorRotation")
		door_open = true

func _on_Area_body_entered(body):
	if(body.name == "FPPlayerLocomotion" || body.name == "VRPlayer"):
		open_door()
