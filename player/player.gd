extends KinematicBody2D

export (int) var speed = 200
var velocity = Vector2.ZERO
var next_position = Vector2.ZERO
var movement_locked = false

func _ready():
	position = position.snapped(Game.tile)
	next_position = position
	$Timer.connect("timeout", self, "unlock_movement")
	$Timer.stop()
	
func _physics_process(delta):
	velocity = Vector2.ZERO
	if (movement_locked):
		return
	
	var x = Input.get_action_strength("move_right") - Input.get_action_strength("move_left")
	var y = Input.get_action_strength("move_down") - Input.get_action_strength("move_up")
	next_position.x = position.x + Game.tile_size * x
	next_position.y = position.y + Game.tile_size * y
	if (next_position != position):
		lock_movement()
		position = next_position
#	velocity.x = x * speed
#	velocity.y = y * speed
#	velocity = move_and_slide(velocity)

func lock_movement():
	$Timer.start()
	movement_locked = true

func unlock_movement():
	movement_locked = false
	