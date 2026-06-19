extends Node2D

@export var mouseHovering1 : bool = false
@export var mouseHovering2 : bool = false
@export var mouseLeftClicked : bool = false
@export var mouseRightClicked : bool = false

@export var hexGenNode : Node2D
@export var hexCalculationsNode : Node2D
@export var resetsMgrNode : Node2D
@export var charactersMovementNode : Node2D

@export var mousePos : Vector2
@export var relativePosArr : Array[Vector2] = []
@export var draggedPosXArr : Array[int] = []
@export var draggedPosYArr : Array[int] = []

@export var is_dragging : bool = false
@export var is_released : bool = false

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	is_dragging = false
	is_released = false

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(_delta: float) -> void:
	mousePos = get_viewport().get_mouse_position()
	_mouse_actions()
	#_print_relative_positions()
	_mouse_path()

func _mouse_mode(_mode : int) -> void:
	var xVal : int = 0
	var yVal : int = 0

	for k in hexGenNode.groundNum:
		if (abs(hexGenNode.groundXWinArr[k] - mousePos.x) <= hexCalculationsNode.xDiff) && (abs(hexGenNode.groundYWinArr[k] - mousePos.y) <= hexCalculationsNode.yDiff):
			xVal = hexGenNode.groundXArr[k]
			yVal = hexGenNode.groundYArr[k]
			break

	if _mode == 0: #HOVERING MODE
		hexGenNode.currentHoverPosX = xVal
		hexGenNode.currentHoverPosY = yVal
		hexGenNode.hoverNode.position.x = hexCalculationsNode._hex_pos_x(xVal, yVal)
		hexGenNode.hoverNode.position.y = hexCalculationsNode._hex_pos_y(xVal, yVal)
	elif _mode == 1: #SELECTION MODE
		hexGenNode.currentSelectionPosX = xVal
		hexGenNode.currentSelectionPosY = yVal
		hexGenNode.selectionNode.position.x = hexCalculationsNode._hex_pos_x(xVal, yVal)
		hexGenNode.selectionNode.position.y = hexCalculationsNode._hex_pos_y(xVal, yVal)
	elif _mode == 2: #ALT SELECTION MODE
		hexGenNode.currentAltSelectionPosX = xVal
		hexGenNode.currentAltSelectionPosY = yVal
		hexGenNode.altSelectionNode.position.x = hexCalculationsNode._hex_pos_x(xVal, yVal)
		hexGenNode.altSelectionNode.position.y = hexCalculationsNode._hex_pos_y(xVal, yVal)

func _mouse_actions() -> void:
	#if Input.is_action_just_pressed("ui_selection"):
	#	_mouse_mode(1)
	#	resetsMgrNode._reset_alt_selection_pos()
	#	selectionEnabled = true
	#else:
		#selectionEnabled = false
	_mouse_mode(0)
	
	#if Input.is_action_just_pressed("ui_alternate_selection"):
		#_mouse_mode(2)
	#else:
		##hovering
		#_mouse_mode(0)

func _input(event: InputEvent) -> void:
	if event is InputEventMouseButton and event.button_index == MOUSE_BUTTON_LEFT:
		if event.is_pressed():
			relativePosArr.clear()
			draggedPosXArr.clear()
			draggedPosYArr.clear()
			resetsMgrNode._reset_path()
			_mouse_mode(1)
			#event.position.distance_to(current_position)
			is_dragging = _mouse_valid_selection()
			is_released = false
		elif event.is_released():
			is_released = true
			is_dragging = false
		else:
			is_dragging = false

	# 2. Check if the mouse is moving while the button is held down
	if event is InputEventMouseMotion and is_dragging:
		var _tempRelativePos : Vector2 = hexGenNode.hoverNode.position - hexGenNode.selectionNode.position

		if _tempRelativePos.length() <= 1.0:
			relativePosArr.clear()
			draggedPosXArr.clear()
			draggedPosYArr.clear()
			resetsMgrNode._reset_path()
		elif relativePosArr.size() == charactersMovementNode.maxMoveLimit:
			return
		elif relativePosArr.size() == 0:
			relativePosArr.append(_tempRelativePos)
			draggedPosXArr.append(hexGenNode.currentHoverPosX)
			draggedPosYArr.append(hexGenNode.currentHoverPosY)
		elif !relativePosArr[relativePosArr.size() - 1].is_equal_approx(_tempRelativePos):
			relativePosArr.append(_tempRelativePos)
			draggedPosXArr.append(hexGenNode.currentHoverPosX)
			draggedPosYArr.append(hexGenNode.currentHoverPosY)

func _print_relative_positions() -> void:
	if relativePosArr.size() == 0:
		return

	print("----------------------")
	print("RelativePositionsOnDrag:")
	for k in relativePosArr.size():
		print(relativePosArr[k])
	print("----------------------")

func _mouse_path() -> void:
	for k in relativePosArr.size():
		hexGenNode.pathXArr[k] = draggedPosXArr[k]
		hexGenNode.pathYArr[k] = draggedPosYArr[k]
		hexGenNode.pathArr[k].position.x = hexCalculationsNode._hex_pos_x(draggedPosXArr[k], draggedPosYArr[k])
		hexGenNode.pathArr[k].position.y = hexCalculationsNode._hex_pos_y(draggedPosXArr[k], draggedPosYArr[k])

func _mouse_valid_selection() -> bool:
	if _mouse_valid_selection_team1_aoe():
		return true

	if _mouse_valid_selection_team2_aoe():
		return true

	if _mouse_valid_selection_team1_archer():
		return true

	if _mouse_valid_selection_team2_archer():
		return true

	if _mouse_valid_selection_team1_melee():
		return true

	if _mouse_valid_selection_team2_melee():
		return true
	return false

func _mouse_valid_selection_team1_aoe() -> bool:
	if hexGenNode.team1AOENode.position.is_equal_approx(hexGenNode.selectionNode.position):
		return true
	return false

func _mouse_valid_selection_team2_aoe() -> bool:
	if hexGenNode.team2AOENode.position.is_equal_approx(hexGenNode.selectionNode.position):
		return true
	return false

func _mouse_valid_selection_team1_archer() -> bool:
	if hexGenNode.team1ArcherNode.position.is_equal_approx(hexGenNode.selectionNode.position):
		return true
	return false

func _mouse_valid_selection_team2_archer() -> bool:
	if hexGenNode.team2ArcherNode.position.is_equal_approx(hexGenNode.selectionNode.position):
		return true
	return false

func _mouse_valid_selection_team1_melee() -> bool:
	if hexGenNode.team1MeleeNode.position.is_equal_approx(hexGenNode.selectionNode.position):
		return true
	return false

func _mouse_valid_selection_team2_melee() -> bool:
	if hexGenNode.team2MeleeNode.position.is_equal_approx(hexGenNode.selectionNode.position):
		return true
	return false
