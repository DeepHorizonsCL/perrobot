extends KinematicBody2D

export (int) var walk_speed = 800
export (int) var jump_speed = -2500
export (int) var gravity = 100
export (float) var run_speed = 2.0

var velocity = Vector2()
var jumping = false
var mov = true
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
	return estado + "_"
	
func get_input():
	velocity.x = 0
	if Input.is_action_just_pressed('ui_select') and is_on_floor():
		jumping = true
	if Input.is_action_pressed('ui_right'):
		velocity.x += walk_speed
	if Input.is_action_pressed('ui_left'):
		velocity.x -= walk_speed
		
	if Input.is_action_pressed("ui_shift"):
		velocity.x *= run_speed

func _physics_process(delta):
	get_input()
	velocity.y += gravity
	flip()
	state_machine()

	if jumping and is_on_floor():
		jumping = false
	if mov:
		velocity = move_and_slide(velocity, Vector2(0, -1))

func flip():
	var es = $animacion.flip_h
	if velocity.x > 0 and !es:
		$animacion.flip_h = true
	elif velocity.x < 0 and es:
		$animacion.flip_h = false
	
func state_machine():
	var estado = str($animacion.animation).split("_")[1]
	match(estado):
		"idle":
			if velocity.x != 0:
				play_anim("walk")
			if jumping:
				play_anim("prejump")
			elif not is_on_floor():
				play_anim("fall")
		"walk":
			if velocity.x == 0:
				play_anim("idle")
			if jumping:
				play_anim("prejump")
				mov = false
			elif not is_on_floor():
				play_anim("fall")
		"jump":
			if velocity.y < 0:
				play_anim("fall")
		"fall":
			if is_on_floor():
				play_anim("land")
				mov = false

func _on_animacion_animation_finished():
	var estado = str($animacion.animation).split("_")[1]
	match(estado):
		"prejump":
			play_anim("jump")
			velocity.y = jump_speed
			mov = true
		"land":
			mov = true
			play_anim("idle")
			
func play_anim(anim):
	if $animacion.animation == anim:
		return
	$animacion.play(estadoCuerpo()+anim)
