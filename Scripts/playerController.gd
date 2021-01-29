extends KinematicBody2D

#dirección
var dir = 1

#movimiento en los ejes
var move_x = 0
var move_y = 0
const gravity_val = 24000
var gravity = 0


export var tope = 700
export var coldownDamage = 0.45
export var coldownGrab = 0.12
var subida = 0

#Variables que afectan al movimiento
var saltando = false
var controlEnSalto = 1
var move = 1
var damage = false
var correr = 1
var dificultadsalto = 1
const corrida = 2.25
var empuje = 0

func _physics_process(delta):
	
	move_x = ( int(Input.is_action_pressed("ui_right")) - int(Input.is_action_pressed("ui_left")) ) * 125 * correr * dificultadsalto * move + empuje


	if Input.is_action_pressed("ui_right"):
		dir = 1

		
	if Input.is_action_pressed("ui_left"):
		dir = -1
		
	if not saltando:
		subida = lerp(subida,0,0.1)
		gravity = gravity_val * delta

	var colliders = move_and_slide(Vector2(move_x,gravity-subida), Vector2(0,-1))
	
	print ("move " + str(move_x) + " _colliders " + str(colliders[0]) + " _gravity "+ str(gravity)  )
	
	if colliders[0] > 0:
		$robotHead.rotation_degrees += 12
	elif colliders[0] < 0:
		$robotHead.rotation_degrees -= 12
		
