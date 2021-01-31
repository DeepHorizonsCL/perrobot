extends KinematicBody2D;

export var piezanombre = ""
export var cantidad = 1

export var estadoRecogible = true;
export var estadoColision = false;


#variables de posicion
var push_x = 50;
var push_y = 50;

#movimiento en los ejes
var move_x = 0
var move_y = 0

#variables de gravedad
var gravity_val = 1224
var gravity = 0

var tope = 700
var topeIni = 1800
var topeMax = 2000
var subida = 0
var bajando = false


func timerStart():
	print("comenzo el timer");
	estadoColision = true;
	$Timer_Gravedad.autostart = true;

func _ready():
	 gravity=gravity_val;

#bucle que se ejecuta todo el tiempo
func _process(delta):
	if(estadoColision):
		if(move_x<=push_y):
			move_x += 0.1;
			move_and_slide(Vector2(move_x,gravity-push_y), Vector2(0,-1));
		
		if(is_on_floor()):
			push_y = 0;
			gravity = 0;
			

func _on_Area2D_body_entered(body):
	if body.is_in_group("player") and estadoRecogible:
		body.add_pieza(piezanombre,cantidad)
		queue_free()

func colisionTrampa():
	if(!estadoRecogible):
		print('oli')

func _on_Timer_Gravedad_timeout():
	print("termino timer");
	gravity=gravity_val;
	estadoRecogible=true;
