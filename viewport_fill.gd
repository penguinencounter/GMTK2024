class_name AutoFillSubViewportContainer
extends SubViewportContainer

var _view: SubViewport


# Called when the node enters the scene tree for the first time.
func _ready():
	_redetect()

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass

func _redetect():
	for child in get_children():
		if child is SubViewport:
			_view = child
			break
	if not _view:
		print("viewport missing")
	
