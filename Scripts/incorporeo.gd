extends Node2D

var bajando = true
var haciarobot =false
var bajada_speed = 62
var speed = 0.45

export (NodePath) var robotopath
onready var roboto = get_node(robotopath) 

export (NodePath) var buttonpath
onready var button = get_node(buttonpath) 

export (NodePath) var camerapath
onready var mycamera = get_node(camerapath) 

export (NodePath) var camerarobopath
onready var robotocamera = get_node(camerarobopath) 



func _ready():
	button.visible = false

func _process(delta):
	if bajando:
		position.y += bajada_speed *delta
		if scale.x < 1.45:
			scale += Vector2(0.0025,0.0025)
			
	if haciarobot:
		global_transform = global_transform.interpolate_with(roboto.global_transform, delta * speed)
			
func activateButton():
	button.visible = true
	
func activateMasita():
	haciarobot = true


func _on_Area2D_body_entered(body):
	if body.is_in_group("player"):
		visible = false
		mycamera.current = false
		robotocamera.make_current()
		roboto. init_robot()
		queue_free()


func _on_Button_pressed():
	activateMasita()
