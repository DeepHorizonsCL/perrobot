extends Node2D

export var crecimiento =  0.012
var poseedor

# Called when the node enters the scene tree for the first time.
func _ready():
	scale += Vector2(0.0012,0.0012)

func _physics_process(_delta):
	crecimiento += 0.12
	scale += Vector2(crecimiento,crecimiento)
	$destello.rotation_degrees += 12
	
	if scale.x > 1:
		crecimiento += 0.012
	
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
