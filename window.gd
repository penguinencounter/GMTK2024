class_name VirtualWindow
extends Control
## A virtual window. Optionally has a close button and/or timer.

## Fires before the close animation plays.
signal pre_close_anim
## Fires after the close animation has played out (or close_destroy called)
## and just before queue_free.
signal pre_destroy

## The content of the window. [Control]s set to fill the space work best.
@export var content: CanvasItem

@onready var _close := %Close as Button
@onready var _close_clicked := _close.pressed
@onready var _display_borders := $DisplayBorders as NinePatchRect
@onready var _animations := $Animations as AnimationPlayer
@onready var _content_slot := %ContentSlot as Control
@onready var _negative_timer := %NegativeTimerDisplay as TextureProgressBar
@onready var _positive_timer := %PositiveTimerDisplay as TextureProgressBar
@onready var _timer := $Timer as Timer

func _refresh_has_close_button(value: bool) -> void:
	if _close != null:
		_close.visible = value

## If this window has a close button. 
@export var has_close_button: bool = true:
	set(value):
		has_close_button = value
		_refresh_has_close_button(value)

func _refresh_timer_mode(value: String) -> void:
	if _negative_timer == null or _positive_timer == null:
		return
	var is_neg := value == "negative"
	var is_pos := value == "positive"
	_negative_timer.visible = is_neg
	_positive_timer.visible = is_pos

@export_enum("none", "negative", "positive") var timer_mode: String = "none":
	set(value):
		timer_mode = value
		_refresh_timer_mode(value)

## Used internally in the close animation to center the pivot on the ninepatch.
func auto_center_pivot() -> void:
	_display_borders.pivot_offset = _display_borders.size / 2.

func _contain(content: Control) -> void:
	content.reparent(_content_slot)
	content.position = Vector2.ZERO

## Close and destroy this window immediately, firing pre_destroy.
func close_destroy() -> void:
	pre_destroy.emit()
	queue_free()

var _borders: Vector2i

var inner_size: Vector2:
	get:
		return size - Vector2(_borders)

func _ready() -> void:
	if content != null:
		if not content.visible:
			content.visible = true
		_contain.call_deferred(content)
	else:
		print("no content smh")
	
	_borders = Vector2i(
		_display_borders.patch_margin_left + _display_borders.patch_margin_right,
		_display_borders.patch_margin_top + _display_borders.patch_margin_bottom
	)
	
	_refresh_has_close_button(has_close_button)
	pre_close_anim.connect(auto_center_pivot)
	_close_clicked.connect(func():
		if not has_close_button:
			print("how'd you manage to hit the close button when its disabled?")
			return
		pre_close_anim.emit()
		_animations.play("close")
	)
	auto_center_pivot()
	_animations.play("open")
