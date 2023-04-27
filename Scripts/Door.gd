extends StaticBody

onready var anim_player = $AnimationPlayer

# Anim not playing by default
func _ready():
	anim_player.stop()

# Turns the light on
func open_door():
	print("Opening door")
	anim_player.play("DoorRotation")

func _on_Area_body_entered(body):
	open_door()
