extends Node2D

var bajando = true
var subiendo = false
var haciarobot =false
export var inicializarrobot = false
var bajada_speed = 112
var subida_speed = 212
var speed = 0.45

export (NodePath) var robotopath
export (NodePath) var buttonpath
export (NodePath) var camerapath
export (NodePath) var camerarobopath
export (NodePath) var nievepath

var roboto
var button 
var mycamera
var robotocamera
var nieve

var destello = preload("res://Objects/destello.tscn")

func _ready():

	if robotopath != "":
		roboto = get_node(robotopath) 
	
	if buttonpath != "":
		button = get_node(buttonpath) 
		
	if camerapath != "":
		mycamera = get_node(camerapath) 
		
	if camerarobopath != "":
		robotocamera = get_node(camerarobopath) 
		
	if nievepath != "":
		nieve = get_node(nievepath) 
		
	if button != null:
		button.visible = false

func _process(delta):
	if bajando:
		position.y += bajada_speed *delta
		if scale.x < 1.45:
			scale += Vector2(0.0025,0.0025)
			
	if subiendo:
		if scale.x < 1.45:
			scale += Vector2(0.0025,0.0025)
		else:
			subida_speed += 12
		position.y -= subida_speed *delta
		rotation_degrees += 6
			
	if haciarobot:
		global_transform = global_transform.interpolate_with(roboto.global_transform, delta * speed)
			
func activateButton():
	print ("soy la masa y me detengo")
	button.visible = true
	bajando = false
	
func activateMasita():
	haciarobot = true


func _on_Area2D_body_entered(body):
	if body.is_in_group("player") and inicializarrobot:
		print("crear destello")
		var new_destello = destello.instance()
		new_destello.poseedor = self
		get_parent().add_child(new_destello)
		new_destello.position = position
		
func activate_roboto():
		visible = false
		if mycamera != null:
			mycamera.current = false
		robotocamera.make_current()
		roboto.mov_user = true
		nieve.emitting = true
		queue_free()

func _on_Button_pressed():
	activateMasita()
