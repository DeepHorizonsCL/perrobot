extends KinematicBody2D


#extremidades
var cantidad_brazos = 0
var cantidad_piernas = 0
var cantidad_torso = 0

#dirección
var dir = 1

#movimiento en los ejes
var move_x = 0
var move_y = 0
var gravity_val = 24000
var gravity = 0


export var tope = 700
export var coldownDamage = 0.45
export var coldownGrab = 0.12
var subida = 0

#Variables que afectan al movimiento
var speed = 125
var jump = false
var saltando = false
var controlEnSalto = 1
var dirSalto = 1
var move = 1
var damage = false
var correr = 1
var dificultadsalto = 1
var dificultadsalto_value = 1
var correr_value = 1
var empuje = 0
var pres = 0.0

#estado actual del robot
var estado_robot = "cabeza"

func _ready():
	updateRoboto("cabeza")
	

func add_pieza(pieza,num):
	
	match pieza:
		"brazo":
			if cantidad_brazos < 2:
				cantidad_brazos += num
				
		"pierna":
			if cantidad_piernas < 2:
				cantidad_piernas += num
			
		"torso":
			if cantidad_torso < 1:
				cantidad_torso += num
				
	update_piezas()
	

func update_piezas():
	if cantidad_brazos == 0 and cantidad_piernas == 0 and cantidad_torso == 0:
		updateRoboto("cabeza")
	
	if cantidad_brazos == 1 and cantidad_piernas == 0 and cantidad_torso == 0:
		updateRoboto("cabeza-brazo")
		
	if cantidad_brazos == 2 and cantidad_piernas == 0 and cantidad_torso == 0:
		updateRoboto("cabeza-2brazos")
		
	if cantidad_brazos == 0 and cantidad_piernas == 1 and cantidad_torso == 0:
		updateRoboto("cabeza-pierna")
		
	if cantidad_brazos == 0 and cantidad_piernas == 2 and cantidad_torso == 0:
		updateRoboto("cabeza-2piernas")
		
	if cantidad_brazos == 0 and cantidad_piernas == 0 and cantidad_torso == 1:
		updateRoboto("cabeza-torso")
		
	if cantidad_brazos == 2 and cantidad_piernas == 0 and cantidad_torso == 1:
		updateRoboto("cabeza-torso-brazos")
		
	if cantidad_brazos == 0 and cantidad_piernas == 2 and cantidad_torso == 1:
		updateRoboto("cabeza-torso-piernas")
		
	if cantidad_brazos == 2 and cantidad_piernas == 2 and cantidad_torso == 1:
		updateRoboto("cuerpo-entero")


func updateRoboto(tranformacion):
	
	estado_robot = tranformacion
	
	match tranformacion:
		"cabeza":
			speed = 125
			gravity_val = 24000
			tope = 512
			correr_value = 1
			
			dificultadsalto_value = 0
			
			$cabeza.visible = true
			$cabeza_mano.visible = false
			$cabeza_2manos.visible = false
			$cabeza_pierna.visible = false
			$cabeza_2piernas.visible = false
			$cabeza_torso.visible = false
			$cabeza_torso_brazos.visible = false
			$cabeza_torso_piernas.visible = false
			$cuerpoentero.visible = false
			
			$colision_inf.disabled = false
			$colision_sup.disabled = true

			
		"cabeza-brazo":
			speed = 625
			gravity_val = 24000
			tope = 1200
			correr_value = 1
			
			dificultadsalto_value = 0.45
			
			$cabeza.visible = false
			$cabeza_mano.visible = true
			$cabeza_2manos.visible = false
			$cabeza_pierna.visible = false
			$cabeza_2piernas.visible = false
			$cabeza_torso.visible = false
			$cabeza_torso_brazos.visible = false
			$cabeza_torso_piernas.visible = false
			$cuerpoentero.visible = false
			
			$colision_inf.disabled = false
			$colision_sup.disabled = false
			
		"cabeza-2brazos":
			speed = 645
			gravity_val = 24000
			tope = 1300
			correr_value = 1
			
			dificultadsalto_value = 0.45
			
			$cabeza.visible = false
			$cabeza_mano.visible = false
			$cabeza_2manos.visible = true
			$cabeza_pierna.visible = false
			$cabeza_2piernas.visible = false
			$cabeza_torso.visible = false
			$cabeza_torso_brazos.visible = false
			$cabeza_torso_piernas.visible = false
			$cuerpoentero.visible = false
			
			$colision_inf.disabled = false
			$colision_sup.disabled = false
			
		"cabeza-pierna":
			speed = 725
			gravity_val = 24000
			tope = 1412
			correr_value = 1.12
			
			dificultadsalto_value = 0.65
			
			$cabeza.visible = false
			$cabeza_mano.visible = false
			$cabeza_2manos.visible = false
			$cabeza_pierna.visible = true
			$cabeza_2piernas.visible = false
			$cabeza_torso.visible = false
			$cabeza_torso_brazos.visible = false
			$cabeza_torso_piernas.visible = false
			$cuerpoentero.visible = false
			
			$colision_inf.disabled = false
			$colision_sup.disabled = false
			
		"cabeza-2piernas":
			speed = 725
			gravity_val = 24000
			tope = 1512
			correr_value = 1.12
			
			dificultadsalto_value = 0.65
			
			$cabeza.visible = false
			$cabeza_mano.visible = false
			$cabeza_2manos.visible = false
			$cabeza_pierna.visible = false
			$cabeza_2piernas.visible = true
			$cabeza_torso.visible = false
			$cabeza_torso_brazos.visible = false
			$cabeza_torso_piernas.visible = false
			$cuerpoentero.visible = false
			
			$colision_inf.disabled = false
			$colision_sup.disabled = false
			
		"cabeza-torso":
			speed = 812
			gravity_val = 24000
			tope = 1120
			correr_value = 2.24
			
			dificultadsalto_value = 1
			
			$cabeza.visible = false
			$cabeza_mano.visible = false
			$cabeza_2manos.visible = false
			$cabeza_pierna.visible = false
			$cabeza_2piernas.visible = false
			$cabeza_torso.visible = true
			$cabeza_torso_brazos.visible = false
			$cabeza_torso_piernas.visible = false
			$cuerpoentero.visible = false
			
			$colision_inf.disabled = false
			$colision_sup.disabled = false
			
		"cabeza-torso-brazos":
			speed = 812
			gravity_val = 24000
			tope = 1412
			correr_value = 2.24
			
			dificultadsalto_value = 1
			
			$cabeza.visible = false
			$cabeza_mano.visible = false
			$cabeza_2manos.visible = false
			$cabeza_pierna.visible = false
			$cabeza_2piernas.visible = false
			$cabeza_torso.visible = false
			$cabeza_torso_brazos.visible = true
			$cabeza_torso_piernas.visible = false
			$cuerpoentero.visible = false
			
			$colision_inf.disabled = false
			$colision_sup.disabled = false
			
		"cabeza-torso-piernas":
			speed = 812
			gravity_val = 24000
			tope = 1512
			correr_value = 2.24
			
			dificultadsalto_value = 1
			
			$cabeza.visible = false
			$cabeza_mano.visible = false
			$cabeza_2manos.visible = false
			$cabeza_pierna.visible = false
			$cabeza_2piernas.visible = false
			$cabeza_torso.visible = false
			$cabeza_torso_brazos.visible = false
			$cabeza_torso_piernas.visible = true
			$cuerpoentero.visible = false
			
			$colision_inf.disabled = false
			$colision_sup.disabled = false
			
		"cuerpo-entero":
			speed = 812
			gravity_val = 24000
			tope = 1600
			correr_value = 2.24
			
			dificultadsalto_value = 1
			
			$cabeza.visible = false
			$cabeza_mano.visible = false
			$cabeza_2manos.visible = false
			$cabeza_pierna.visible = false
			$cabeza_2piernas.visible = false
			$cabeza_torso.visible = false
			$cabeza_torso_brazos.visible = false
			$cabeza_torso_piernas.visible = false
			$cuerpoentero.visible = true
			
			$colision_inf.disabled = false
			$colision_sup.disabled = false
			
		
			
		

func _physics_process(delta):
	
	if estado_robot == "cabeza":
		move_x = ( pres ) * speed * correr * dificultadsalto * move + empuje
	elif estado_robot == "cabeza-pierna" or estado_robot == "cabeza-torso" :
		if not is_on_floor():
			move_x = ( int(Input.is_action_pressed("ui_right")) - int(Input.is_action_pressed("ui_left")) ) * speed * correr * dificultadsalto * move + empuje
		else:
			move_x = 0
	else:
		move_x = ( int(Input.is_action_pressed("ui_right")) - int(Input.is_action_pressed("ui_left")) ) * speed * correr * dificultadsalto * move + empuje

	if abs(pres) > 0:
		pres = pres / 1.32
		if abs(pres)<0.01:
			pres = 0.0
			
	if Input.is_action_pressed("ui_right"):
		dir = 1
		pres += 1.0

		
	if Input.is_action_pressed("ui_left"):
		dir = -1
		pres -= 1.0

	if is_on_floor():
		dificultadsalto = 1
		jump = true
		
#Correr


	if Input.is_action_pressed("ui_run"):
		#print("running")
		correr = correr_value
		#$SpriteUp.speed_scale = 2.65
		#$SpriteDown.speed_scale = 2.65
	else:
		correr = 1
		#$SpriteUp.speed_scale = 2.12
		#$SpriteDown.speed_scale = 2.64

#Saltos
	
	if Input.is_action_just_pressed("ui_accept") and is_on_floor() and jump == true:
		print("salto")
		saltando = true
	
	if Input.is_action_pressed("ui_accept") and move != 0:
		jump = false
		empuje = 0
		
		if saltando:
			dificultadsalto = dificultadsalto_value
			if subida < tope*0.95:
				if estado_robot == "cabeza" :
					subida = lerp(subida,tope, 0.1)
				else:
					subida = lerp(subida,tope, 0.1)
			else:
				saltando = false
				dirSalto = dir

		
	elif Input.is_action_just_released("ui_accept") and saltando:
		saltando = false
		dirSalto = dir
	
	if not saltando:
		subida = 0
		gravity = gravity_val * delta
		#print (gravity)

	var colliders = move_and_slide(Vector2(move_x,gravity-subida), Vector2(0,-1))
	

	
	#print ("move " + str(move_x) + " _colliders " + str(colliders[0]) + " _gravity "+ str(gravity)  )
	
	if colliders[0] > 0:
		$cabeza.rotation_degrees += 12
	elif colliders[0] < 0:
		$cabeza.rotation_degrees -= 12


