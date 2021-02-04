extends KinematicBody2D

export (int) var walk_speed = 800
export (int) var gravity = 100
export (float) var run_speed_value = 1.64
var run_speed = 1

var velocity = Vector2()
var dir = 0
var mov = true
var mov_user = false
var canwalk = 1

export (bool) var pierna = false
export (bool) var brazo = false
export (bool) var torso = false

var jumping = false
var jump_max = -2500
var jump_min = -1000
var jump_plus = -5000
var jump = 0
export (float) var jump_retroceso = 1.0
var jump_retroceso_value = 0.45
var dir_jump = 1

"""
#Lista de estados 
c : cabeza (NO esta)
cb: cabeza brazis (esta, agrgada) 
cp: cabeza piernas (esta , agregada)
cpb: cabeza piernas brazos (esta, agregada)
ct: cabeza torso (esta, agregada)
ctp: cabeza torso piernas (esta, agregada)
ctb: cabeza torso brazos (esta, agregada)
ctpb: caebza torso piernas brazos "Cuerpo completo" (esta, agregada)
c_break: cabeza rota "Muerto" (no esta)
"""
	
func get_input(delta):
	
	var estadocuerpo = estadoCuerpo()
	
	velocity.x = 0
	
	var walk_final_speed = canwalk * walk_speed * jump_retroceso * run_speed
	
	
	if mov_user:
		if jumping and Input.is_action_pressed("ui_accept"):
			jump = max(jump+(delta*jump_plus),jump_max)
		elif Input.is_action_just_pressed("ui_accept") and is_on_floor():
			jumping = true
			jump = jump_min
		if Input.is_action_pressed('ui_right'):
			velocity.x += walk_final_speed
			dir = 1
		if Input.is_action_pressed('ui_left'):
			velocity.x -= walk_final_speed
			dir = -1
		if Input.is_action_pressed("ui_shift"):
			if is_on_floor():
				run_speed = run_speed_value
		else:
			run_speed = 1

func _physics_process(delta):
	
	get_input(delta)
	velocity.y += gravity
	if mov_user:
		flip()
	state_machine()

	if mov:
		velocity = move_and_slide(velocity, Vector2(0, -1))
	#Dificultad de retroceso en el salto
	if jumping: 
		if dir_jump == dir:
			jump_retroceso = 1
		else:
			jump_retroceso = jump_retroceso_value
	else: 
		jump_retroceso = 1

func flip():
	var es = $animacion.flip_h
	if not jumping:
		if velocity.x > 0 and !es:
			$animacion.flip_h = true
			dir = 1
		elif velocity.x < 0 and es:
			$animacion.flip_h = false
			dir = -1
	
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
	var estadoroboto = estadoCuerpo()
	
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
				
			if estadoroboto == "ct_":
				canwalk = 0
			else:
				canwalk = 1
				
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
				
			if estadoroboto == "ct_":
				canwalk = 0
			else:
				canwalk = 1
				
		"jump":
			if velocity.y < 0:
				play_anim("fall")
				
			canwalk = 1

		"fall":
			if is_on_floor():
				play_anim("land")
				mov = false
				
			canwalk = 1

func _on_animacion_animation_finished():
	var estado = str($animacion.animation).split("_")[1]
	match(estado):
		"prejump":
			play_anim("jump")
			velocity.y = jump
			mov = true
			#Seteo la dirección del salto
			dir_jump = dir
		"land":
			mov = true
			jump = 0
			jumping = false
			velocity.y = 0
			play_anim("idle")
			dir_jump = 0

func play_anim(anim):
	if $animacion.animation == anim:
		return
	$animacion.play(estadoCuerpo()+anim)
