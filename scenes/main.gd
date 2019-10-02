extends Node2D
const N = 0x1
const E = 0x2
const S = 0x3
const W = 0x4
var cell_walls = {
	Vector2(0,-1):N,
	Vector2(1,0):E,
	Vector2(0,1):S,
	Vector2(-1,0):W
	}
onready var Map = $Map
var tileset
onready var player = preload("res://scenes/player.tscn")
onready var baseEnemy = preload("res://scenes/baseEnemy.tscn")
func _ready():
	
	var player_instance = player.instance()
	var enemy_instance = baseEnemy.instance()
	player_instance.position = Map.map_to_world(player_instance.map_pos) + Vector2(0,20) 
	enemy_instance.position = Vector2(get_viewport_rect().size.x/2,get_viewport_rect().size.y/2)
	player_instance.map = Map
	add_child(player_instance)
	add_child(enemy_instance)
	tileset = Map.get_tileset()
	for i in range(50):
		for n in range(100):
			
			Map.set_cell(i,n,randi() % 3)
	
func _process(delta):
	randomize()
	
func generate_map(cell):
	var cellarr : Array = []
	for i in range(10):
		for n in range(10):
			Map.set_cell((int(cell.x)+i),(int(cell.y)+n),randi() % 3)
	
#func find_valid_cell(cell):
#	var valid_tiles = []
#	for i in range(3):
#		var is_match = false
#		for n in cell_walls.keys():
#			var neighbour_id = Map.get_cellv(cell + n)
#			if neighbour_id >= 0:
#				if (neighbour_id & cell_walls[-n])/cell_walls[-n] == (i & cell_walls[n])/cell_walls[n]:
#					is_match = true
#				else:
#					is_match = false
#					break
#		if is_match &&  ! i in valid_tiles:
#			valid_tiles.append(i)
#	return valid_tiles

func _on_VisibilityNotifier2D_viewport_exited(viewport):
	pass
