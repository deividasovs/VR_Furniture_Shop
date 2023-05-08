extends CSGBox

onready var anim_player = $ButtonDownAnim
onready var sound_player = $AudioStreamPlayer3D

# public variables for convenience 
export var material_to_modify: SpatialMaterial = null
export var button_material: SpatialMaterial = null

export var texture_1: Texture = null
export var texture_2: Texture = null

# Change the Albedo of a material
func _ready():
	material_to_modify.albedo_texture = texture_1
	button_material.albedo_texture = texture_2

func _change_material():
	var curr_texture = material_to_modify.albedo_texture
	sound_player.play()
	anim_player.playback_speed = 1
	anim_player.play("ButtonDown")
	
	if(curr_texture == texture_1):
		material_to_modify.albedo_texture = texture_2
		button_material.albedo_texture = texture_1
	else:
		material_to_modify.albedo_texture = texture_1
		button_material.albedo_texture = texture_2


func _on_Area_body_entered(body):
	if(body.name == "FPPlayerLocomotion" || body.name == "VRPlayer"):
		_change_material()


func _on_Area_body_exited(body):
	if(body.name == "FPPlayerLocomotion" || body.name == "VRPlayer"):
			anim_player.playback_speed = -1
			anim_player.play("ButtonDown")
