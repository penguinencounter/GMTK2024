class_name VirtualWindow
extends Control
## A virtual window. Optionally has a close button.

## Fires before the close animation plays.
signal pre_close_anim
## Fires after the close animation has played out (or close_destroy called)
## and just before queue_free.
signal pre_destroy

@export var _content: CanvasItem

@onready var _close: Button = $DisplayBorders/Close
@onready var _close_clicked := _close.pressed
@onready var _display_borders: NinePatchRect = $DisplayBorders
@onready var _close_animation: AnimationPlayer = $CloseAnimation
@onready var _content_slot: Control = %ContentSlot

func _refresh_has_close_button(value: bool) -> void:
	if _close != null:
		_close.visible = value

## If this window has a close button. 
@export var has_close_button: bool = true:
	set(value):
		has_close_button = value
		_refresh_has_close_button(value)

## Used internally in the close animation to center the pivot on the ninepatch.
func auto_center_pivot() -> void:
	_display_borders.pivot_offset = _display_borders.size / 2.

func _contain(content: Control) -> void:
	content.reparent(_content_slot)
	content.position = Vector2.ZERO

func _ready() -> void:
	if _content != null:
		if not _content.visible:
			_content.visible = true
		_contain.call_deferred(_content)
	else:
		print("no content smh")
	_refresh_has_close_button(has_close_button)
	pre_close_anim.connect(auto_center_pivot)
	_close_clicked.connect(func():
		if not has_close_button:
			print("how'd you manage to hit the close button when its disabled?")
			return
		pre_close_anim.emit()
		_close_animation.play("close")
	)

## Close and destroy this window immediately, firing pre_destroy.
func close_destroy() -> void:
	pre_destroy.emit()
	queue_free()
