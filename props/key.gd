tool
extends Pawn

enum KEY_TYPE {
	SIMPLE,
	DOUBLE,
	BIG,
	RUSTY
}

export (KEY_TYPE) var key_type = KEY_TYPE.SIMPLE setget _set_key_type
const REGION_SIZE = Vector2(16, 16)

var key_sprite_regions = {
	KEY_TYPE.SIMPLE: 0,
	KEY_TYPE.DOUBLE: 16,
	KEY_TYPE.BIG: 32,
	KEY_TYPE.RUSTY: 64,
}

func _ready() -> void:
	_set_key_type(key_type)

func _set_key_type(new_type) -> void:
	key_type = new_type
	region_rect = _get_key_region()

func _get_key_region(offset: int = 0) -> Rect2:
	return Rect2(Vector2(key_sprite_regions[key_type] + offset, 128), REGION_SIZE)

func _on_area_entered(area: Area2D) -> void:
	var target = area.get_parent()
	if target.get('keys') != null:
		target.keys += 1
		queue_free()