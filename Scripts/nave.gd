extends Node2D


var estado = 1
var speed = 65
var second_speed = 12
var decrease_value = 0.00025

export (NodePath) var masitapath
onready var masita = get_node(masitapath) 

func _ready():
	pass # Replace with function body.



func _process(delta):
	if estado == 1:
		position.x += speed *delta
		scale -= Vector2(0.000001,0.000001)
	if estado == 2:
		position.x += second_speed *delta
		if scale.x > 0.01:
			scale -= Vector2(decrease_value,decrease_value)


func _on_cambioRitmo_timeout():
	print ("stopMasita")
	estado = 2
	masita.activateButton()
