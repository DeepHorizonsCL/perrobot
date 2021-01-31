extends Node2D

export var piezanombre = ""
export var cantidad = 1

func _on_Area2D_body_entered(body):
	if body.is_in_group("player"):
		body.add_pieza(piezanombre,cantidad)
		queue_free()

