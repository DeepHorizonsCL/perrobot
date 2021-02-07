extends StaticBody2D
var activo = true
export var tiposBloqueo = ["cabeza"]
onready var colision = $Collision

func _ready():
	colision.set_deferred("disabled", true)

func _on_Area2D_body_entered(body):
	var bloquear = false
	if body.is_in_group("player"):
		print ("entro el player")
		for i in tiposBloqueo: 
			if body.estado_robot == i:
				print("este qlo no pasa")
				colision.set_deferred("disabled", false)
				bloquear = true
	if bloquear == false:
		colision.set_deferred("disabled", true)
		
func _on_Area2D_body_exited(_body):
	print(colision.disabled)
