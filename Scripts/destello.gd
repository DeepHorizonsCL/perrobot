extends Node2D

export var crecimiento =  0.65
var poseedor

# Called when the node enters the scene tree for the first time.
func _ready():
	scale += Vector2(0.012,0.012)

func _process(delta):
	scale += Vector2(crecimiento,crecimiento)
	$destello.rotation_degrees += 12
	
	if scale.x > 8:
		change_camera()
		modulate.a -= 0.02
		
	if modulate.a < 0.01:
		visible = false
	

func change_camera():
	if poseedor != null:
		poseedor.activate_roboto()


func _on_Timer_timeout():
	change_camera()
	#queue_free()
