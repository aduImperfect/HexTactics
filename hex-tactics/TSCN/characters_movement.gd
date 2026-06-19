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
	#_char_input_action()
	#
	#if _check_move_success() == false:
		#return
#
	#if hexCollisionsNode._player_hit_goal(currCharPosX, currCharPosY):
		#stopGame = true
#
	#_update_char_move()
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

	if (mouseControls.is_released == false) && (mouseControls.relativePosArr.size() != 0):
		if mouseControls._mouse_valid_selection_team1_aoe() == true:
			pass

func _move_direction(_dirVal : String, _yOdd : bool) -> Vector2i:
	var relativePosInts : Vector2i
	if _dirVal == "NW":
		if _yOdd == true:
			relativePosInts.x = -1
		relativePosInts.y = -1
	elif _dirVal == "NE":
		if _yOdd == false:
			relativePosInts.x = 1
		relativePosInts.y = -1
	elif _dirVal == "E":
		relativePosInts.x = 1
	elif _dirVal == "SE":
		if _yOdd == false:
			relativePosInts.x = 1
		relativePosInts.y = 1
	elif _dirVal == "SW":
		if _yOdd == true:
			relativePosInts.x = -1
		relativePosInts.y = 1
	elif _dirVal == "W":
		relativePosInts.x = -1
	return relativePosInts

#func _check_move_success() -> bool:
	#if hexCollisionsNode._player_hit_wall(currCharPosX, currCharPosY):
		##return back to previous spot (aka) - no movement done this frame.
		#currCharPosX = prevCharPosX
		#currCharPosY = prevCharPosY
		#return false
	#return true

#func _update_char_move() -> void:
	#hexGenNode.playerNode.position.x = hexCalculationsNode._hex_pos_x(currCharPosX, currCharPosY)
	#hexGenNode.playerNode.position.y = hexCalculationsNode._hex_pos_y(currCharPosX, currCharPosY)
