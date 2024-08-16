extends Node2D

@export var right: AnimatableBody2D
@export var bottom: AnimatableBody2D

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _physics_process(delta: float) -> void:
	var window_size := get_window().size
	right.position.x = window_size.x
	bottom.position.y = window_size.y
