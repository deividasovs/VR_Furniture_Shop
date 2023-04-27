extends StaticBody

# references the light that is used for the lamp
# IMPORTANT: If you rename your light, you will need to change this line.
onready var test_platform = $TestPlatform

# Turned off by default
func _ready():
	test_platform.transform.origin = Vector3(4, 0.8, 8)
	

func _on_Area_body_entered(body):
	print("abc")
	test_platform.transform.origin = Vector3(8, 0.8, 8)


func _on_Area_body_exited(body):
	test_platform.transform.origin = Vector3(4, 0.8, 8)
