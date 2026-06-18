extends Node2D

@export var mouseHovering1 : bool = false
@export var mouseHovering2 : bool = false
@export var mouseLeftClicked : bool = false
@export var mouseRightClicked : bool = false

@export var hexGenNode : Node2D
@export var hexCalculationsNode : Node2D

@export var mouse_pos : Vector2

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(_delta: float) -> void:
	mouse_pos = get_viewport().get_mouse_position()
	_mouse_hover()
	#_mouse_inputs()

func _mouse_hover() -> void:
	var xVal : int = hexCalculationsNode._hex_win_to_pos_x(mouse_pos.x, mouse_pos.y)
	var yVal : int = hexCalculationsNode._hex_win_to_pos_y(mouse_pos.x, mouse_pos.y)
	print(str(xVal) + ":" + str(yVal))

	hexGenNode.hoverNode.position.x = hexCalculationsNode._hex_pos_x(xVal, yVal)
	hexGenNode.hoverNode.position.y = hexCalculationsNode._hex_pos_y(xVal, yVal)
	#print(str(hexGenNode.hoverNode.position.x) + ":" + str(hexGenNode.hoverNode.position.y))

func _mouse_inputs() -> void:
	if Input.is_action_just_pressed("ui_selection"):
		pass
	if Input.is_action_just_pressed("ui_alternate_selection"):
		pass

func _mouse_at_position(_x : int, _y : int) -> bool:
	for k in hexGenNode.groundNum:
		if (hexGenNode.groundArr[k] == _x) && (hexGenNode.groundArr[k] == _y): 
			return true
	return false
