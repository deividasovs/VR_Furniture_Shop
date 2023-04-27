extends KinematicBody

export var speed = 10 # how fast the player moves
export var acceleration = 5 # how quickly the player accelerates
export var gravity = 0.98 # gravity constant (for earth)
export var jump_power = 50 # how high the player can jump
export var mouse_sensitivity = 0.3 # the higher, the more sensitive are mouse movements

var angleX = 0 # current vertical angle of players head
export var maxAngle = 90 # maximum degree for looking down/up (positive is down, negative is up)
export var headAngleLocomotionTrigger = 10 # degrees when player start moving (positive is forward, negative is backward) 

onready var head = $Head
onready var camera = $Head/Camera

var velocity = Vector3()
var camera_x_rotation = 0 # tracks camera movement along x-axis (to avoid overturning)

func _ready():
	# hide mouse
	Input.set_mouse_mode(Input.MOUSE_MODE_CAPTURED)

func _process(delta):
	# show mouse, if user wants to cancel
	if Input.is_action_just_pressed("ui_cancel"):
		Input.set_mouse_mode(Input.MOUSE_MODE_VISIBLE)

func _input(event):
	# hide mouse again, if user clicks 
	if event is InputEventMouseButton:
		Input.set_mouse_mode(Input.MOUSE_MODE_CAPTURED)
	
	# mouse movement to position head (direction and tilt)
	if event is InputEventMouseMotion:
		head.rotate_y(deg2rad(-event.relative.x * mouse_sensitivity))
		# only move camera up or down if it is within the 90 degree boundary (so to not overturn)
		var x_delta = event.relative.y * mouse_sensitivity
		# absolute X angle
		angleX =  camera_x_rotation + x_delta
		#print ("Angle X: ", angleX)		
		if camera_x_rotation + x_delta > -maxAngle and camera_x_rotation + x_delta < maxAngle:
			camera.rotate_x(deg2rad(-x_delta))
			camera_x_rotation += x_delta

func _physics_process(delta):
	var head_basis = head.get_global_transform().basis
	var direction = Vector3()
	# keyboard movements (locomotion from keys)
	if Input.is_action_pressed("move_forward"):
		direction -= head_basis.z
	elif Input.is_action_pressed("move_backward"):
		direction += head_basis.z
	if Input.is_action_pressed("move_left"):
		direction -= head_basis.x
	elif Input.is_action_pressed("move_right"):
		direction += head_basis.x
	if Input.is_action_just_pressed("move_jump") and is_on_floor():
		velocity.y += jump_power 
	# head movements (locomotion from head position/angle)
	if (angleX > headAngleLocomotionTrigger):
		direction -= head_basis.z # move foreward
	# normalise movement
	direction = direction.normalized()
	velocity = velocity.linear_interpolate(direction * speed, acceleration * delta)
	# gravity
	velocity.y -= gravity
	# moving, after all...
	velocity = move_and_slide(velocity, Vector3.UP)
