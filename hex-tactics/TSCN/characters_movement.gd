extends Node2D

@export var hexGenNode : Node2D
@export var hexCalculationsNode : Node2D
@export var hexCollisionsNode : Node2D
@export var mouseControls : Node2D
@export var resetsMgrNode : Node2D

@export var prevCharTeam1AOEPosX : int = 0
@export var prevCharTeam1AOEPosY : int = 0
@export var currCharTeam1AOEPosX : int = 0
@export var currCharTeam1AOEPosY : int = 0

@export var prevCharTeam2AOEPosX : int = 0
@export var prevCharTeam2AOEPosY : int = 0
@export var currCharTeam2AOEPosX : int = 0
@export var currCharTeam2AOEPosY : int = 0

@export var prevCharTeam1ArcherPosX : int = 0
@export var prevCharTeam1ArcherPosY : int = 0
@export var currCharTeam1ArcherPosX : int = 0
@export var currCharTeam1ArcherPosY : int = 0

@export var prevCharTeam2ArcherPosX : int = 0
@export var prevCharTeam2ArcherPosY : int = 0
@export var currCharTeam2ArcherPosX : int = 0
@export var currCharTeam2ArcherPosY : int = 0

@export var prevCharTeam1MeleePosX : int = 0
@export var prevCharTeam1MeleePosY : int = 0
@export var currCharTeam1MeleePosX : int = 0
@export var currCharTeam1MeleePosY : int = 0

@export var prevCharTeam2MeleePosX : int = 0
@export var prevCharTeam2MeleePosY : int = 0
@export var currCharTeam2MeleePosX : int = 0
@export var currCharTeam2MeleePosY : int = 0

@export var initialCharsPosSet : bool = false

@export var stopGame : bool = false

@export var maxMoveLimit : int = 3

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	maxMoveLimit = 3

	prevCharTeam1AOEPosX = 0
	prevCharTeam1AOEPosY = 0
	currCharTeam1AOEPosX = 0
	currCharTeam1AOEPosY = 0

	prevCharTeam2AOEPosX = 0
	prevCharTeam2AOEPosY = 0
	currCharTeam2AOEPosX = 0
	currCharTeam2AOEPosY = 0

	prevCharTeam1ArcherPosX = 0
	prevCharTeam1ArcherPosY = 0
	currCharTeam1ArcherPosX = 0
	currCharTeam1ArcherPosY = 0

	prevCharTeam2ArcherPosX = 0
	prevCharTeam2ArcherPosY = 0
	currCharTeam2ArcherPosX = 0
	currCharTeam2ArcherPosY = 0

	prevCharTeam1MeleePosX = 0
	prevCharTeam1MeleePosY = 0
	currCharTeam1MeleePosX = 0
	currCharTeam1MeleePosY = 0

	prevCharTeam2MeleePosX = 0
	prevCharTeam2MeleePosY = 0
	currCharTeam2MeleePosX = 0
	currCharTeam2MeleePosY = 0

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(_delta: float) -> void:
	if initialCharsPosSet == false:
		_initial_chars_pos()
		initialCharsPosSet = true

	if stopGame == true:
		return
#
	_char_input_action()

	#if _check_move_success() == false:
		#return
#
	#if hexCollisionsNode._player_hit_goal(currCharPosX, currCharPosY):
		#stopGame = true
#
	_update_chars_move()
	pass

func _initial_chars_pos() -> void:

	prevCharTeam1AOEPosX = hexGenNode.team1AOEPosX
	prevCharTeam1AOEPosY = hexGenNode.team1AOEPosY
	currCharTeam1AOEPosX = hexGenNode.team1AOEPosX
	currCharTeam1AOEPosY = hexGenNode.team1AOEPosY

	prevCharTeam2AOEPosX = hexGenNode.team2AOEPosX
	prevCharTeam2AOEPosY = hexGenNode.team2AOEPosY
	currCharTeam2AOEPosX = hexGenNode.team2AOEPosX
	currCharTeam2AOEPosY = hexGenNode.team2AOEPosY

	prevCharTeam1ArcherPosX = hexGenNode.team1ArcherPosX
	prevCharTeam1ArcherPosY = hexGenNode.team1ArcherPosY
	currCharTeam1ArcherPosX = hexGenNode.team1ArcherPosX
	currCharTeam1ArcherPosY = hexGenNode.team1ArcherPosY

	prevCharTeam2ArcherPosX = hexGenNode.team2ArcherPosX
	prevCharTeam2ArcherPosY = hexGenNode.team2ArcherPosY
	currCharTeam2ArcherPosX = hexGenNode.team2ArcherPosX
	currCharTeam2ArcherPosY = hexGenNode.team2ArcherPosY

	prevCharTeam1MeleePosX = hexGenNode.team1MeleePosX
	prevCharTeam1MeleePosY = hexGenNode.team1MeleePosY
	currCharTeam1MeleePosX = hexGenNode.team1MeleePosX
	currCharTeam1MeleePosY = hexGenNode.team1MeleePosY

	prevCharTeam2MeleePosX = hexGenNode.team2MeleePosX
	prevCharTeam2MeleePosY = hexGenNode.team2MeleePosY
	currCharTeam2MeleePosX = hexGenNode.team2MeleePosX
	currCharTeam2MeleePosY = hexGenNode.team2MeleePosX

func _char_input_action() -> void:
	prevCharTeam1AOEPosX = currCharTeam1AOEPosX
	prevCharTeam1AOEPosY = currCharTeam1AOEPosY

	prevCharTeam2AOEPosX = currCharTeam2AOEPosX
	prevCharTeam2AOEPosY = currCharTeam2AOEPosY

	prevCharTeam1ArcherPosX = currCharTeam1ArcherPosX
	prevCharTeam1ArcherPosY = currCharTeam1ArcherPosY

	prevCharTeam2ArcherPosX = currCharTeam2ArcherPosX
	prevCharTeam2ArcherPosY = currCharTeam2ArcherPosY

	prevCharTeam1MeleePosX = currCharTeam1MeleePosX
	prevCharTeam1MeleePosY = currCharTeam1MeleePosY

	prevCharTeam2MeleePosX = currCharTeam2MeleePosX
	prevCharTeam2MeleePosY = currCharTeam2MeleePosY

	if (mouseControls.is_released == true) && (mouseControls.relativePosArr.size() != 0):
		if mouseControls._mouse_valid_selection_team1_aoe() == true:
			currCharTeam1AOEPosX = mouseControls.draggedPosXArr[mouseControls.draggedPosXArr.size() - 1]
			currCharTeam1AOEPosY = mouseControls.draggedPosYArr[mouseControls.draggedPosYArr.size() - 1]
			mouseControls.relativePosArr.clear()
			mouseControls.draggedPosXArr.clear()
			mouseControls.draggedPosYArr.clear()
			resetsMgrNode._reset_path()

		if mouseControls._mouse_valid_selection_team2_aoe() == true:
			currCharTeam2AOEPosX = mouseControls.draggedPosXArr[mouseControls.draggedPosXArr.size() - 1]
			currCharTeam2AOEPosY = mouseControls.draggedPosYArr[mouseControls.draggedPosYArr.size() - 1]
			mouseControls.relativePosArr.clear()
			mouseControls.draggedPosXArr.clear()
			mouseControls.draggedPosYArr.clear()
			resetsMgrNode._reset_path()

		if mouseControls._mouse_valid_selection_team1_archer() == true:
			currCharTeam1ArcherPosX = mouseControls.draggedPosXArr[mouseControls.draggedPosXArr.size() - 1]
			currCharTeam1ArcherPosY = mouseControls.draggedPosYArr[mouseControls.draggedPosYArr.size() - 1]
			mouseControls.relativePosArr.clear()
			mouseControls.draggedPosXArr.clear()
			mouseControls.draggedPosYArr.clear()
			resetsMgrNode._reset_path()

		if mouseControls._mouse_valid_selection_team2_archer() == true:
			currCharTeam2ArcherPosX = mouseControls.draggedPosXArr[mouseControls.draggedPosXArr.size() - 1]
			currCharTeam2ArcherPosY = mouseControls.draggedPosYArr[mouseControls.draggedPosYArr.size() - 1]
			mouseControls.relativePosArr.clear()
			mouseControls.draggedPosXArr.clear()
			mouseControls.draggedPosYArr.clear()
			resetsMgrNode._reset_path()

		if mouseControls._mouse_valid_selection_team1_melee() == true:
			currCharTeam1MeleePosX = mouseControls.draggedPosXArr[mouseControls.draggedPosXArr.size() - 1]
			currCharTeam1MeleePosY = mouseControls.draggedPosYArr[mouseControls.draggedPosYArr.size() - 1]
			mouseControls.relativePosArr.clear()
			mouseControls.draggedPosXArr.clear()
			mouseControls.draggedPosYArr.clear()
			resetsMgrNode._reset_path()

		if mouseControls._mouse_valid_selection_team2_melee() == true:
			currCharTeam2MeleePosX = mouseControls.draggedPosXArr[mouseControls.draggedPosXArr.size() - 1]
			currCharTeam2MeleePosY = mouseControls.draggedPosYArr[mouseControls.draggedPosYArr.size() - 1]
			mouseControls.relativePosArr.clear()
			mouseControls.draggedPosXArr.clear()
			mouseControls.draggedPosYArr.clear()
			resetsMgrNode._reset_path()

#func _check_move_success() -> bool:
	#if hexCollisionsNode._player_hit_wall(currCharPosX, currCharPosY):
		##return back to previous spot (aka) - no movement done this frame.
		#currCharPosX = prevCharPosX
		#currCharPosY = prevCharPosY
		#return false
	#return true

func _update_chars_move() -> void:
	hexGenNode.team1AOENode.position.x = hexCalculationsNode._hex_pos_x(currCharTeam1AOEPosX, currCharTeam1AOEPosY)
	hexGenNode.team1AOENode.position.y = hexCalculationsNode._hex_pos_y(currCharTeam1AOEPosX, currCharTeam1AOEPosY)

	hexGenNode.team2AOENode.position.x = hexCalculationsNode._hex_pos_x(currCharTeam2AOEPosX, currCharTeam2AOEPosY)
	hexGenNode.team2AOENode.position.y = hexCalculationsNode._hex_pos_y(currCharTeam2AOEPosX, currCharTeam2AOEPosY)

	hexGenNode.team1ArcherNode.position.x = hexCalculationsNode._hex_pos_x(currCharTeam1ArcherPosX, currCharTeam1AOEPosY)
	hexGenNode.team1ArcherNode.position.y = hexCalculationsNode._hex_pos_y(currCharTeam1ArcherPosX, currCharTeam1AOEPosY)

	hexGenNode.team2ArcherNode.position.x = hexCalculationsNode._hex_pos_x(currCharTeam2ArcherPosX, currCharTeam2ArcherPosY)
	hexGenNode.team2ArcherNode.position.y = hexCalculationsNode._hex_pos_y(currCharTeam2ArcherPosX, currCharTeam2ArcherPosY)

	hexGenNode.team1MeleeNode.position.x = hexCalculationsNode._hex_pos_x(currCharTeam1MeleePosX, currCharTeam1AOEPosY)
	hexGenNode.team1MeleeNode.position.y = hexCalculationsNode._hex_pos_y(currCharTeam1MeleePosX, currCharTeam1AOEPosY)

	hexGenNode.team2MeleeNode.position.x = hexCalculationsNode._hex_pos_x(currCharTeam2MeleePosX, currCharTeam2ArcherPosY)
	hexGenNode.team2MeleeNode.position.y = hexCalculationsNode._hex_pos_y(currCharTeam2MeleePosX, currCharTeam2ArcherPosY)
