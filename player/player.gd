extends Actor

export (int) var speed = 100
var last_position = Vector2.ZERO
var next_position = Vector2.ZERO
var direction = Vector2.ZERO

onready var raycast: RayCast2D = $RayCast
onready var grid

func initialize(grid: Grid) -> void:
	self.grid = grid

func _ready() -> void:
	position = position.snapped(Game.tile)
	last_position = position
	next_position = position
	
func _process(delta) -> void:
	if raycast.is_colliding():
		position = last_position
		next_position = last_position
	else:
		position += speed * direction * delta
	
		if position.distance_to(last_position)  >= Game.tile_size - speed * delta:
			position = next_position
	
	if position == next_position:
		direction = _get_direction()
		last_position = position
		next_position += direction * Game.tile_size
	
	if direction != Vector2.ZERO:
		raycast.cast_to = direction * Game.tile_size / 2

func _unhandled_input(event: InputEvent):
	if event.is_action_pressed('interact') && raycast.is_colliding():
		var point = raycast.get_collision_point()
		var look_direction = raycast.cast_to.normalized()
		var target = position + look_direction * Game.tile_size / 2
		print(look_direction)
		print(point)
		print(position)
		print(target)
		grid.request_interaction(point)
#		print('*********')
	
func _get_direction() -> Vector2:
	return Vector2(
		Input.get_action_strength("move_right") - Input.get_action_strength("move_left"),
		Input.get_action_strength("move_down") - Input.get_action_strength("move_up")
	)
	