extends Node

onready var player = get_tree().root.find_node('Player', true, false)
var tile_size = 16
var tile = Vector2(tile_size, tile_size)

signal tick

func _ready():
	player.connect('player_action', self, '_on_player_action')

func _on_player_action():
	emit_signal('tick')

func _unhandled_input(event):
	if event.is_action_pressed("reset"):
		get_tree().reload_current_scene()