extends Node2D

var _window: VirtualWindow
@onready var timer := $Timer as Timer

func set_window(window: VirtualWindow):
	_window = window
	_late_ready()

func _bump():
	_window.resize_inner(_window.inner_size + Vector2(10, 10))

func _late_ready():
	timer.start()
	_window.resize_inner(Vector2(50, 20), true)
	timer.timeout.connect(_bump)

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass
