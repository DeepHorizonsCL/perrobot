extends Node2D

export var piezanombre = ""

func _on_Area2D_body_entered(body):
	if body.is_in_group("player"):
		body.updateRoboto(piezanombre)
		queue_free()
