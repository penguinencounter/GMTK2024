extends Node2D


# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.

@onready var _base := self.position

var total := 0.
# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float):
	total += delta
	self.position = _base + Vector2(10 * sin(total * 2), 10 * cos(total * 2))
