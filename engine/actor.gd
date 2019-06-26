extends Pawn
class_name Actor

export (int) var speed = 100
var last_position = Vector2.ZERO
var next_position = Vector2.ZERO
var direction = Vector2.ZERO
var grid: Grid
onready var raycast: RayCast2D = $RayCast

func initialize(grid: Grid) -> void:
	self.grid = grid

func _ready() -> void:
	position = position.snapped(Game.tile)
	self.last_position = position
	self.next_position = position
	
func move(delta) -> void:
	position += speed * direction * delta
	
	if position.distance_to(last_position)  >= Game.tile_size - speed * delta:
		position = next_position

func reset_positions() -> void:
	position = last_position
	next_position = last_position

func update_next_position() -> void:
	last_position = position
	next_position += direction * Game.tile_size

func update_raycast_direction() -> void:
	if direction != Vector2.ZERO:
		raycast.cast_to = direction * Game.tile_size / 2
#	if raycast.is_colliding():
#		position = last_position
#		next_position = last_position
#	else:
#		position += speed * direction * delta
#
#	if position.distance_to(last_position)  >= Game.tile_size - speed * delta:
#		position = next_position
#
#	if position == next_position:
#		if direction.x != 0 and direction.y != 0:
#			direction = Vector2.ZERO
#		last_position = position
#		next_position += direction * Game.tile_size
#
#	if direction != Vector2.ZERO:
#		raycast.cast_to = direction * Game.tile_size / 2

func _get_direction():
	print('_get_direction NOT IMPLEMENTED')