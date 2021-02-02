extends KinematicBody2D

export (int) var run_speed = 800
export (int) var jump_speed = -2500
export (int) var gravity = 100

var velocity = Vector2()
var jumping = false

export (bool) var pierna = false
export (bool) var brazo = false
export (bool) var torso = false

func estadoCuerpo():
	var estado = "c"
	if torso:
		estado += "t"
	if pierna:
		estado += "p"
	if brazo:
		estado += "b"
	print(estado)
	
		
		

func get_input():
	velocity.x = 0
	var right = Input.is_action_pressed('ui_right')
	var left = Input.is_action_pressed('ui_left')
	var jump = Input.is_action_just_pressed('ui_select')

	if jump and is_on_floor():
		jumping = true
		velocity.y = jump_speed
	if right:
		velocity.x += run_speed
	if left:
		velocity.x -= run_speed

func _physics_process(delta):
	estadoCuerpo()
	get_input()
	velocity.y += gravity
	if jumping and is_on_floor():
		jumping = false
	velocity = move_and_slide(velocity, Vector2(0, -1))
