extends Actor
class_name Player

var keys = 0 setget _set_keys

signal key_added(keys)
signal player_action

func _ready():
	Game.connect('tick', self, '_on_game_tick')
	
func _process(delta) -> void:
	if raycast.is_colliding():
		var collider = raycast.get_collider()
		if collider.has_method('interact'):
			collider.interact(self)
			emit_signal('player_action')
		reset_positions()
	else:
		move(delta)
	
	if position == next_position:
		direction = _get_direction()
		if direction.x != 0 and direction.y != 0:
			direction = Vector2.ZERO
		if direction != Vector2.ZERO:
			emit_signal('player_action')
		update_next_position()
	
	update_raycast_direction()

	
func _get_direction() -> Vector2:
	return Vector2(
		Input.get_action_strength("move_right") - Input.get_action_strength("move_left"),
		Input.get_action_strength("move_down") - Input.get_action_strength("move_up")
	)

func _set_keys(new_amount):
	emit_signal('key_added', new_amount)
	keys = new_amount

func _on_game_tick():
	print('The game has ticked')