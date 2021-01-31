extends KinematicBody2D;

export var piezanombre = ""
export var cantidad = 1
export var estadoColision = false;

func _on_Area2D_body_entered(body):
	if body.is_in_group("player"):
		body.add_pieza(piezanombre,cantidad)
		queue_free()

func colisionTrampa():
	if(!estadoColision):
		print('oli')
