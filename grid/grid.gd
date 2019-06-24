extends TileMap
class_name Grid

onready var pawns = $Pawns

func _ready():
	for pawn in pawns.get_children():
		pawn.initialize(self)

func request_interaction(tile_coords: Vector2) -> void:
	var cell_index = get_cell(tile_coords.x, tile_coords.y)
	print(cell_index)
	if cell_index >= 0:
		var name = get_tileset().tile_get_name(cell_index)
		print(name)
	print('************')
	