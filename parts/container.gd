class_name MicrogameContainer
extends SubViewportContainer

var _window: VirtualWindow
@export var game: Node
var _game_set_window: Callable

func _ready():
	_game_set_window = Interfaces.expect(game, "set_window", 1)

func set_window(window: VirtualWindow):
	_game_set_window.call(window)
	_window = window
