extends StaticBody

# references the light that is used for the lamp
# IMPORTANT: If you rename your light, you will need to change this line.
onready var test_platform = $SampleUIPoppup

# Turned off by default
func _ready():
	test_platform.transform.origin = Vector3(8, -1, 5)
	

func _on_Area_body_entered(body):
	# Could probably animate this up instead
	test_platform.transform.origin = Vector3(8, 1, 5)
