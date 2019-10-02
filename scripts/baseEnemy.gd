extends KinematicBody2D
onready var Bullet = preload("res://scenes/bullet.tscn")
export var speed = 200
var Bullet_instance
var vector_dir
var velocity
var can_shoot
var Playerpos
var shape
export (Vector2) var enemySize = Vector2(35,35) 
export (Color) var enemyColor = Color(0,0,1)
func _ready():
	
	shape = RectangleShape2D.new()
	shape.set_extents(enemySize)
	Playerpos = get_parent().get_node("player")
	
func _physics_process(delta):
	walk()
	if(can_shoot):
		shoot(Playerpos.global_position)
	
func shoot(pos):
	Bullet_instance = Bullet.instance()
	Bullet_instance.position = $Position2D.global_position
	var a = (pos - $Position2D.global_position).angle()
	Bullet_instance.start($Position2D.global_position + Vector2(0,20), a + rand_range(-0.02, 0.02))
	get_parent().add_child(Bullet_instance)
	can_shoot = false
	$shootTimer.start()
func walk():
	#dont over think
	var a = Vector2()
	
	var dir = Playerpos.global_position - global_position
	rotation = dir.angle() + rand_range(-0.02, 0.02)
	if(global_position.distance_to(Playerpos.global_position)<=1):
		print("ds")
	move_and_slide(dir)
	

func _draw():
	draw_rect(Rect2(Vector2.ZERO,enemySize),enemyColor)
	$CollisionShape2D.shape = shape
func _on_shootTimer_timeout():
	can_shoot = true
