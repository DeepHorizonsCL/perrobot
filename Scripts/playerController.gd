extends KinematicBody2D


#extremidades
var cantidad_brazos = 0
var cantidad_piernas = 0
var cantidad_torso = 0
var parte = preload("res://Objects/Player/parterobot.tscn")
var nubecita = preload("res://Objects/Player/incorporeo.tscn")
var actual_ani 
var notdeath = 0

#Music
export (NodePath) var cancionpath
onready var cancion = get_node(cancionpath)

#dirección
var dir = 1

#movimiento en los ejes
var move_x = 0
var move_y = 0
var gravity_val = 1224
var gravity = 0


var tope = 700
var topeIni = 1800
var topeMax = 2000
var subida = 0
var bajando = false

#Variables que afectan al movimiento
var speed = 125
var prejump = false
var jump = false
var saltando = false
var postsalto = false
var sumador_salto = 0
var controlEnSalto = 1
var devolverseEnSalto = 1
var devolverEnSalto_value = 1
var dirSalto = 1
var move = 1
var damage = false
var correr = 1
var dificultadsalto = 1
var dificultadsalto_value = 1
var correr_value = 1
var empuje = 0
var pres = 0.0

#
var inmunidadTemporal = false

#estado actual del robot
var estado_robot = "vacio"

func _ready():
	#updateRoboto("cabeza")
	actual_ani = $ani_cabeza_brazos_piernas
	
func init_robot():
	print ("inciar robot")
	updateRoboto("cabeza")
	move = 1
	notdeath = 1
	cancion.play()
	
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
		
	if cantidad_brazos == 2 and cantidad_piernas == 2 and cantidad_torso == 0:
		updateRoboto("cabeza-brazos_piernas")
		
	if cantidad_brazos == 0 and cantidad_piernas == 0 and cantidad_torso == 1:
		updateRoboto("cabeza-torso")
		
	if cantidad_brazos == 2 and cantidad_piernas == 0 and cantidad_torso == 1:
		updateRoboto("cabeza-torso-brazos")
		
	if cantidad_brazos == 0 and cantidad_piernas == 2 and cantidad_torso == 1:
		updateRoboto("cabeza-torso-piernas")
		
	if cantidad_brazos == 2 and cantidad_piernas == 2 and cantidad_torso == 1:
		updateRoboto("cuerpo-entero")

func animation_finished():
	print ("Hola")
	

func updateRoboto(tranformacion):
	
	estado_robot = tranformacion
	
	match tranformacion:
		"cabeza":
			print("cabeza")
			speed = 125
			topeMax = 1850
			correr_value = 1
			
			dificultadsalto_value = 0
			devolverEnSalto_value = 0.45
			
			actual_ani = $ani_cabeza_brazos_piernas
			
			$cabeza.visible = true
			$cabeza_mano.visible = false
			$cabeza_2manos.visible = false
			$cabeza_pierna.visible = false
			$cabeza_2piernas.visible = false
			$cabeza_brazos_piernas.visible = false
			$cabeza_torso.visible = false
			$cabeza_torso_brazos.visible = false
			$cabeza_torso_piernas.visible = false
			$cuerpoentero.visible = false
			
			#$colision_inf.disabled = false
			#$colision_sup.disabled = true

			
		"cabeza-brazo":
			speed = 625
			topeMax = 2500
			
			correr_value = 1
			
			dificultadsalto_value = 0.45
			devolverEnSalto_value = 0.45
			
			$cabeza.visible = false
			$cabeza_mano.visible = true
			$cabeza_2manos.visible = false
			$cabeza_pierna.visible = false
			$cabeza_2piernas.visible = false
			$cabeza_brazos_piernas.visible = false
			$cabeza_torso.visible = false
			$cabeza_torso_brazos.visible = false
			$cabeza_torso_piernas.visible = false
			$cuerpoentero.visible = false
			
			#$colision_inf.disabled = false
			#$colision_sup.disabled = false
			
		"cabeza-2brazos":
			speed = 645
			topeMax = 2600
			correr_value = 1
			
			dificultadsalto_value = 0.45
			devolverEnSalto_value = 0.45
			
			$cabeza.visible = false
			$cabeza_mano.visible = false
			$cabeza_2manos.visible = true
			$cabeza_pierna.visible = false
			$cabeza_2piernas.visible = false
			$cabeza_brazos_piernas.visible = false
			$cabeza_torso.visible = false
			$cabeza_torso_brazos.visible = false
			$cabeza_torso_piernas.visible = false
			$cuerpoentero.visible = false
			
			#$colision_inf.disabled = false
			#$colision_sup.disabled = false
			
		"cabeza-pierna":
			speed = 120
			topeMax = 2600
			correr_value = 1.12
			
			dificultadsalto_value = 0.65
			devolverEnSalto_value = 0.45
			
			$cabeza.visible = false
			$cabeza_mano.visible = false
			$cabeza_2manos.visible = false
			$cabeza_pierna.visible = true
			$cabeza_2piernas.visible = false
			$cabeza_brazos_piernas.visible = false
			$cabeza_torso.visible = false
			$cabeza_torso_brazos.visible = false
			$cabeza_torso_piernas.visible = false
			$cuerpoentero.visible = false
			
			#$colision_inf.disabled = false
			#$colision_sup.disabled = false
			
		"cabeza-2piernas":
			speed = 725
			topeMax = 2700
			correr_value = 1.12
			
			dificultadsalto_value = 0.65
			devolverEnSalto_value = 0.45
			
			$cabeza.visible = false
			$cabeza_mano.visible = false
			$cabeza_2manos.visible = false
			$cabeza_pierna.visible = false
			$cabeza_2piernas.visible = true
			$cabeza_brazos_piernas.visible = false
			$cabeza_torso.visible = false
			$cabeza_torso_brazos.visible = false
			$cabeza_torso_piernas.visible = false
			$cuerpoentero.visible = false
			
			#$colision_inf.disabled = false
			#$colision_sup.disabled = false
			
			
		"cabeza-brazos_piernas":
			speed = 812
			topeMax = 2800
			correr_value = 1.12
			
			dificultadsalto_value = 0.85
			devolverEnSalto_value = 0.45
			
			$cabeza.visible = false
			$cabeza_mano.visible = false
			$cabeza_2manos.visible = false
			$cabeza_pierna.visible = false
			$cabeza_2piernas.visible = true
			$cabeza_brazos_piernas.visible = true
			$cabeza_torso.visible = false
			$cabeza_torso_brazos.visible = false
			$cabeza_torso_piernas.visible = false
			$cuerpoentero.visible = false
			
			#$colision_inf.disabled = false
			#$colision_sup.disabled = false
			
			
		"cabeza-torso":
			speed = 812
			topeMax = 2500
			correr_value = 2.24
			
			dificultadsalto_value = 1
			devolverEnSalto_value = 0.45
			
			$cabeza.visible = false
			$cabeza_mano.visible = false
			$cabeza_2manos.visible = false
			$cabeza_pierna.visible = false
			$cabeza_2piernas.visible = false
			$cabeza_brazos_piernas.visible = false
			$cabeza_torso.visible = true
			$cabeza_torso_brazos.visible = false
			$cabeza_torso_piernas.visible = false
			$cuerpoentero.visible = false
			
			#$colision_inf.disabled = false
			#$colision_sup.disabled = false
			
		"cabeza-torso-brazos":
			speed = 812
			topeMax = 2600
			correr_value = 2.24
			
			dificultadsalto_value = 1
			devolverEnSalto_value = 0.45
			
			$cabeza.visible = false
			$cabeza_mano.visible = false
			$cabeza_2manos.visible = false
			$cabeza_pierna.visible = false
			$cabeza_2piernas.visible = false
			$cabeza_brazos_piernas.visible = false
			$cabeza_torso.visible = false
			$cabeza_torso_brazos.visible = true
			$cabeza_torso_piernas.visible = false
			$cuerpoentero.visible = false
			
			#$colision_inf.disabled = false
			#$colision_sup.disabled = false
			
		"cabeza-torso-piernas":
			speed = 812
			topeMax = 2700
			correr_value = 2.24
			
			dificultadsalto_value = 1
			devolverEnSalto_value = 0.45
			
			$cabeza.visible = false
			$cabeza_mano.visible = false
			$cabeza_2manos.visible = false
			$cabeza_pierna.visible = false
			$cabeza_2piernas.visible = false
			$cabeza_brazos_piernas.visible = false
			$cabeza_torso.visible = false
			$cabeza_torso_brazos.visible = false
			$cabeza_torso_piernas.visible = true
			$cuerpoentero.visible = false
			
			#$colision_inf.disabled = false
			#$colision_sup.disabled = false
			
		"cuerpo-entero":
			speed = 832
			topeMax = 3112
			correr_value = 2.24
			
			dificultadsalto_value = 1
			devolverEnSalto_value = 0.65
			
			$cabeza.visible = false
			$cabeza_mano.visible = false
			$cabeza_2manos.visible = false
			$cabeza_pierna.visible = false
			$cabeza_2piernas.visible = false
			$cabeza_brazos_piernas.visible = false
			$cabeza_torso.visible = false
			$cabeza_torso_brazos.visible = false
			$cabeza_torso_piernas.visible = false
			$cuerpoentero.visible = true
			
			#$colision_inf.disabled = false
			#$colision_sup.disabled = false
		

func _physics_process(delta):
	
	if estado_robot == "vacio":
		move = 0
	if estado_robot == "cabeza":
		move_x = ( pres ) * speed * correr * dificultadsalto * move * notdeath + empuje 
	elif estado_robot == "cabeza-pierna" :
		if not is_on_floor():
			speed = 720
		else:
			speed = 125
		move_x = ( int(Input.is_action_pressed("ui_right")) - int(Input.is_action_pressed("ui_left")) ) * speed * correr * dificultadsalto * devolverseEnSalto * move * notdeath + empuje  
	elif estado_robot == "cabeza-torso" :
		if not is_on_floor():
			move_x = ( int(Input.is_action_pressed("ui_right")) - int(Input.is_action_pressed("ui_left")) ) * speed * correr * dificultadsalto * devolverseEnSalto * move * notdeath + empuje
		else:
			move_x = 0
	else:
		move_x = ( int(Input.is_action_pressed("ui_right")) - int(Input.is_action_pressed("ui_left")) ) * speed * correr * dificultadsalto * devolverseEnSalto * move * notdeath + empuje

	if abs(pres) > 0:
		pres = pres / 1.32
		if abs(pres)<0.01:
			pres = 0.0

	if Input.is_action_pressed("ui_right") and move != 0:
		dir = 1
		pres += 1.0
		if is_on_floor(): 
			actual_ani.flip_h = true

		
	if Input.is_action_pressed("ui_left") and move != 0:
		dir = -1
		pres -= 1.0
		if is_on_floor(): 
			actual_ani.flip_h = false

	if is_on_floor():
		dificultadsalto = 1
		dirSalto = dir
		#print("salatando " + str(saltando) + " prejump " + str(prejump) + " bajando " + str(bajando))
		if saltando == false and prejump == false and bajando == false:
			#print ("las ani")
			if move_x != 0:
				#print ("walk")
				actual_ani.animation = "walk"
			else:
				#print ("iddle")
				actual_ani.animation = "idle"
		
	else:
		if dir == dirSalto:
			devolverseEnSalto = 1
		else:
			devolverseEnSalto = devolverEnSalto_value
		#print ("dirSalto " + str(dirSalto == dir) + " " + str(dirSalto) + " VS "+ str(dir))
#Correr
	if Input.is_action_pressed("ui_run"):
		print("running")
		correr = correr_value
		#$SpriteUp.speed_scale = 2.65
		#$SpriteDown.speed_scale = 2.65
	else:
		correr = 1
		#$SpriteUp.speed_scale = 2.12
		#$SpriteDown.speed_scale = 2.64

#Saltos
	
	if Input.is_action_just_pressed("ui_accept") and is_on_floor() and not bajando and not prejump and move == 1 :
		#print("salto")
		saltando = false
		prejump = true
		dirSalto = dir
		tope = topeIni
		#print ("dir " + str(dir) + " dirSalto " + str(dirSalto))
		actual_ani.animation = "pre_jump"
	
	if Input.is_action_pressed("ui_accept") and is_on_floor() and not bajando and prejump:
		move = 0
		saltando = false
		jump = false
		prejump = true
		if tope < topeMax:
			tope += 64
			#print ("tope: " +  str(tope) + " "  +str(prejump))
		empuje = 0
		
	"""
	elif Input.is_action_just_released("ui_accept"):
		move = 1
		print("comence el salto")
		prejump = false
		saltando = true
	"""
	
	if saltando:
		move = 1
		bajando = false
		prejump = false
		if subida < tope:
			subida = lerp(subida,tope+0.1, 0.42)
			#subida += (1000 + sumador_salto)
			#sumador_salto += 60
		else:
			subida  = tope
			saltando = false
			tope = 0
			subida = 0
		#print (" subida: " +  str(subida) + " VS tope: " + str(tope)  +  ' VS Tope MAX:  ' + str(topeMax) )
		actual_ani.animation = "jump"
	else :
		gravity = gravity_val
		if not is_on_floor():
			prejump = false
			bajando = true
			actual_ani.animation = "post_jump"
		else:
			if bajando:
				actual_ani.animation = "land"
				move = 0
	#print ("bajando" + str(bajando))

	var colliders = move_and_slide(Vector2(move_x,gravity-subida), Vector2(0,-1))
	

	
	#print ("move " + str(move_x) + " _colliders " + str(colliders[0]) + " _gravity "+ str(gravity)  )
	
	if colliders[0] > 0:
		$cabeza.rotation_degrees += 12
	elif colliders[0] < 0:
		$cabeza.rotation_degrees -= 12
		

		

func dano():
	if inmunidadTemporal == false:
		inmunidadTemporal = true
		modulate.a = 0.45
		print("ouch")

		
		if cantidad_brazos > 1:
			expulsarParte("brazo",-200)
			
		if cantidad_piernas > 1:
			expulsarParte("pierna",+300)
			
		if cantidad_torso > 0:
			expulsarParte("torso",-300)
			
		if cantidad_brazos + cantidad_piernas + cantidad_torso == 0:
			move = 0
			notdeath = 0
			#visible = false
			var new_nubesita = nubecita.instance()
			new_nubesita.subiendo = true
			get_parent().add_child(new_nubesita)
			new_nubesita.position +=  Vector2(position.x, position.y)
			$TimerMuerte.start()
		else:
			cantidad_brazos = 0
			cantidad_piernas = 0
			cantidad_torso = 0
			
			update_piezas()
		
			$TimerInmune.start()


func _on_TimerInmune_timeout():
	print ("termino de inmunidad")
	if inmunidadTemporal == true:
		inmunidadTemporal = false
		modulate.a = 1
		
func expulsarParte(nombre,distancia):
	var nuevaparte = parte.instance()
	nuevaparte.piezanombre = nombre
	nuevaparte.estadoRecogible = false;

	nuevaparte.timerStart();
	match nombre:
		"brazo":
			nuevaparte.cantidad =2 
		"pierna":
			nuevaparte.cantidad =2
		"torso":
			nuevaparte.cantidad =1
			
	
	get_parent().add_child(nuevaparte)
	nuevaparte.position +=  Vector2(position.x+distancia, position.y-200)
	
func checkParte(nombre):
	match nombre:
		"brazo":
			if cantidad_brazos > 1:
				return false
		"pierna":
			if cantidad_piernas > 1:
				return false
		"torso":
			if cantidad_torso > 1:
				return false
	return true

func _on_ani_cabeza_brazos_piernas_animation_finished():
	if $ani_cabeza_brazos_piernas.animation == "pre_jump":
		print("comence el salto")
		prejump = false
		saltando = true
		move = 1
		sumador_salto = 6
		
		
	if $ani_cabeza_brazos_piernas.animation == "land" and is_on_floor() and bajando:
		move = 1
		prejump = false
		bajando = false



func _on_TimerMuerte_timeout():
	get_tree().reload_current_scene()
