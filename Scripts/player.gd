extends KinematicBody2D

export (int) var walk_speed = 800
#export (int) var jump_speed = -2500
export (int) var gravity = 100
export (float) var run_speed = 2.0

var velocity = Vector2()
var jumping = false

var mov = true
export (bool) var pierna = false
export (bool) var brazo = false
export (bool) var torso = false

var jump_max = -2500
var jump_min = -1000
var jump_plus = -5000
var jump = 0
	
func get_input(delta):
	velocity.x = 0
	if jumping and Input.is_action_pressed("ui_accept"):
		jump = max(jump+(delta*jump_plus),jump_max)
		print(jump)
	elif Input.is_action_just_pressed("ui_accept") and is_on_floor():
		jumping = true
		jump = jump_min
	if Input.is_action_pressed('ui_right'):
		velocity.x += walk_speed
	if Input.is_action_pressed('ui_left'):
		velocity.x -= walk_speed
	if Input.is_action_pressed("ui_shift"):
		velocity.x *= run_speed

func _physics_process(delta):
	get_input(delta)
	velocity.y += gravity
	flip()
	state_machine()

	#if jumping and is_on_floor():
	#	jumping = false
	if mov:
		velocity = move_and_slide(velocity, Vector2(0, -1))

func flip():
	var es = $animacion.flip_h
	if velocity.x > 0 and !es:
		$animacion.flip_h = true
	elif velocity.x < 0 and es:
		$animacion.flip_h = false
	
func estadoCuerpo():
	var estado = "c"
	if torso:
		estado += "t"
	if pierna:
		estado += "p"
	if brazo:
		estado += "b"
	return estado + "_"

func state_machine():
	var estado = str($animacion.animation).split("_")[1]
	match(estado):
		"idle":
			if velocity.x != 0:
				play_anim("walk")
			if jumping:
				play_anim("prejump")
			elif not is_on_floor():
				var col = $RayCast2D.get_collider()
				if col:
					if col.is_in_group("plataform"):
						return
				play_anim("fall")
		"walk":
			if velocity.x == 0:
				play_anim("idle")
			if jumping:
				play_anim("prejump")
				mov = false
			elif not is_on_floor():
				var col = $RayCast2D.get_collider()
				if col:
					if col.is_in_group("plataform"):
						return
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
			velocity.y = jump
			mov = true
		"land":
			mov = true
			jump = 0
			jumping = false
			velocity.y = 0
			play_anim("idle")

func play_anim(anim):
	if $animacion.animation == anim:
		return
	$animacion.play(estadoCuerpo()+anim)
