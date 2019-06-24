extends Sprite

class_name Pawn

enum PAWN_TYPE {
	ACTOR
	PROP
	OBSTACLE
}
export(PAWN_TYPE) var type = PAWN_TYPE.ACTOR

func initialize(grid: Grid):
	pass