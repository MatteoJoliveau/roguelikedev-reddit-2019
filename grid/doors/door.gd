tool
extends StaticBody2D

enum DOOR_TYPE {
	SIMPLE,
	DOORWAY,
	DOUBLE,
	GATE
}

enum DOOR_STATUS {
	OPEN,
	CLOSED
}

export (DOOR_TYPE) var door_type = DOOR_TYPE.SIMPLE setget _set_door_type
const REGION_SIZE = Vector2(16, 16)

var door_sprite_regions = {
	DOOR_TYPE.SIMPLE: 32,
	DOOR_TYPE.DOORWAY: 64,
	DOOR_TYPE.DOUBLE: 96,
	DOOR_TYPE.GATE: 128,
}

var status = DOOR_STATUS.CLOSED

onready var sprite: Sprite = $Sprite
onready var collisions: CollisionShape2D = $Collisions

func _ready() -> void:
	_set_door_type(door_type)

func _set_door_type(new_type) -> void:
	door_type = new_type
	if sprite:
		sprite.region_rect = _get_closed_door_region()
	
func _get_closed_door_region() -> Rect2:
	return _get_door_region()
	
func _get_open_door_region() -> Rect2:
	return _get_door_region(16)
	
func _get_door_region(offset: int = 0) -> Rect2:
	return Rect2(Vector2(door_sprite_regions[door_type] + offset, 0), REGION_SIZE)

func _toggle() -> void:
	match status:
		DOOR_STATUS.OPEN:
			sprite.region_rect = _get_closed_door_region()
			status = DOOR_STATUS.CLOSED
			collisions.disabled = false
		DOOR_STATUS.CLOSED:
			
			collisions.disabled = true
			
func interact(target):
	queue_free()