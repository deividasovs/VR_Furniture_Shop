extends Spatial

onready var texture1 = preload("res://Scenes/Models/wood1.jpg")
onready var texture2 = preload("res://Scenes/Models/wood2.jpg")

var current_texture = texture1

func _ready():
	pass

func _input(event):
	if event is InputEventKey and event.pressed and event.scancode == KEY_C:
		if current_texture == texture1:
			$Cube/MeshInstance.get_active_material(0).set_texture(SpatialMaterial.TEXTURE_ALBEDO, texture2)
			current_texture = texture2
		else:
			$Cube/MeshInstance.get_active_material(0).set_texture(SpatialMaterial.TEXTURE_ALBEDO, texture1)
			current_texture = texture1
		print("Texture Changed!");
