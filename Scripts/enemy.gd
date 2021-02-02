extends KinematicBody2D

export (int) var run_speed = 60
export (int) var gravity = 120

var velocity = Vector2()
var jumping = false
var dir = 1

func _physics_process(delta):
	var izq = $izq.get_collider()
	var der = $der.get_collider()
	#print(izq)
	if not der and izq:
		dir = -1
	elif der and not izq:
		dir = 1
		
	if is_on_wall():
		dir *= -1
		
	$AnimatedSprite.scale.x = abs($AnimatedSprite.scale.x) * -dir
		
	velocity.x = run_speed * dir
	velocity.y += gravity
	velocity = move_and_slide(velocity, Vector2(0, -1))
	
	for i in get_slide_count():
		var col = get_slide_collision(i).collider
		if col.is_in_group("player"):
			col.dano()
		
