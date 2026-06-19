extends Node2D

@export var xMult : float = 0.0
@export var yMult : float = 0.0
@export var xDiff : float = 0.0
@export var yDiff : float = 0.0
@export var _xOffset : int = 4

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	xMult = 42.5
	yMult = 42.5
	xDiff = 21.25
	yDiff = 21.25
	_xOffset = 4

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(_delta: float) -> void:
	pass

func _hex_pos_x(_x : int, _y : int) -> float:
	if _y % 2 != 0:
		return _hex_pos_calc_x(_x, _y) - (_y * _xval_calc(_x, _y))
	else:
		return _hex_pos_calc_x(_x, _y) - ((_y - 1) * _xval_calc(_x, _y))

func _hex_pos_y(_x : int, _y : int) -> float:
	return _hex_pos_calc_y(_x, _y) - ((_y - 1) * (_xval_calc(_x, _y) / 2))

func _hex_pos_calc_x(_x : int, _y : int) -> float:
	return ((_x + _xOffset) * xMult) + ((_y * yMult) - yDiff) / 2

func _hex_pos_calc_y(_x : int, _y : int) -> float:
	return (_y * yMult)

func _xval_calc(_x : int, _y : int) -> float:
		return _hex_pos_calc_x(_x, _y + 1) - _hex_pos_calc_x(_x, _y)
