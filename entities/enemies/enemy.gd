extends Actor

func _ready() -> void:
	Game.connect('tick', self, '_on_game_tick')

func _process(delta) -> void:
	if raycast.is_colliding():
		var inverted = raycast.cast_to.normalized()
		if inverted.x != 0:
			inverted.x = -inverted.x
		if inverted.y != 0:
			inverted.y = -inverted.y
		direction = inverted
		reset_positions()
	move(delta)
	if position == next_position:
		direction = Vector2.ZERO
	
	update_raycast_direction()

func _get_direction() -> Vector2:
	return Vector2(randi() % 3 - 1, randi() % 3 - 1)

func _on_game_tick() -> void:
	direction = _get_direction()
	update_next_position()