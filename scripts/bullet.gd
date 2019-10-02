extends Area2D

var speed = 1000
var velocity = Vector2()
var shape
export var bullet_radius = 3
export (Color) var bulletColor = Color(1,0,0)
func _ready():
	shape = CircleShape2D.new()
	shape.radius = bullet_radius
	
func start(pos, dir):
	position = pos
	rotation = dir
	velocity = Vector2(speed, 0).rotated(dir)

func _physics_process(delta):
	position += velocity * delta
func _draw():
	
	draw_circle(Vector2(),bullet_radius,Color(0.2,0.3,0.12));
	$CollisionShape2D.shape = shape 

func _on_VisibilityNotifier2D_screen_exited():
	queue_free()


func _on_bullet_body_shape_entered(body_id, body, body_shape, area_shape):
	queue_free()
