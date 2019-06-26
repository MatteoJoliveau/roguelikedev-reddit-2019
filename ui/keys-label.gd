extends Label

onready var player = get_tree().get_root().find_node("Player", true, false)

func _ready():
	text = str(player.keys)
	player.connect('key_added', self, '_on_user_keys_updated')

func _on_user_keys_updated(keys):
	text = str(keys)