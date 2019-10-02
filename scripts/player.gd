extends KinematicBody2D
var dir
var can_shoot
var map = null
var map_pos = Vector2()
export var speed = 800
onready var Bullet = preload("res://scenes/bullet.tscn");
func _ready():
	pass

func _physics_process(delta):
	getInput();
	rotate_player(get_global_mouse_position())
	

func rotate_player(vect: Vector2):
	rotation = (vect - global_position).angle()
 
func shoot(pos):
	var b = Bullet.instance()
	var r = (pos - global_position).angle()
	b.start(global_position, r + rand_range(-0.05, 0.05))
	get_parent().add_child(b)
	can_shoot = false
	$Timer.start()

func can_move(dir):
	var t = map.get_cellv(dir)
	if t & 1:
		return false
	else:
		return true

func getInput():
	dir = Vector2()
	if Input.is_action_pressed("ui_left"):
		dir.x -= speed 
	if Input.is_action_pressed("ui_right"):
		dir.x += speed
	if Input.is_action_pressed("ui_up"):
		dir.y -= speed
	if Input.is_action_pressed("ui_down"):
		dir.y += speed	
	if Input.is_mouse_button_pressed(BUTTON_LEFT):
		if(can_shoot):
			shoot(get_global_mouse_position())
	
	dir.normalized()
	map_pos = global_position
	if map.get_cellv(map_pos) == -1:
		print(map.get_cellv(map_pos))
		get_parent().generate_map(map_pos)
	map.map_to_world(map_pos) + Vector2(0,100)
	move_and_slide(dir)

func _on_Timer_timeout():
	can_shoot = true
