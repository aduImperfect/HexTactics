extends Node2D

@export var hexGenNode : Node2D
@export var hexCalculationsNode : Node2D
@export var hexCollisionsNode : Node2D

@export var prevPlayerPosX : int = 0
@export var prevPlayerPosY : int = 0

@export var currPlayerPosX : int = 0
@export var currPlayerPosY : int = 0

@export var initialPlayerPosSet : bool = false

@export var stopGameOnGoalReached : bool = false

@export var maxMoveLimit : int = 3

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	prevPlayerPosX = 0
	prevPlayerPosY = 0
	currPlayerPosX = 0
	currPlayerPosY = 0
	maxMoveLimit = 3

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(_delta: float) -> void:
	if initialPlayerPosSet == false:
		_initial_player_pos()
		initialPlayerPosSet = true

	if stopGameOnGoalReached == true:
		return

	_player_input_action()
	
	if _check_move_success() == false:
		return

	if hexCollisionsNode._player_hit_goal(currPlayerPosX, currPlayerPosY):
		stopGameOnGoalReached = true

	_update_player_move()

func _initial_player_pos() -> void:
	prevPlayerPosX = hexGenNode.playerPosX
	prevPlayerPosY = hexGenNode.playerPosY
	currPlayerPosX = hexGenNode.playerPosX
	currPlayerPosY = hexGenNode.playerPosY
	maxMoveLimit = 3

func _player_input_action() -> void:
	prevPlayerPosX = currPlayerPosX
	prevPlayerPosY = currPlayerPosY

	#if Input.is_action_just_pressed("ui_nw"):
		#if currPlayerPosY % 2 != 0:
			#currPlayerPosX -= 1
		#currPlayerPosY -= 1
	#elif Input.is_action_just_pressed("ui_ne"):
		#if currPlayerPosY % 2 == 0:
			#currPlayerPosX += 1
		#currPlayerPosY -= 1
	#elif Input.is_action_just_pressed("ui_e"):
		#currPlayerPosX += 1
	#elif Input.is_action_just_pressed("ui_se"):
		#if currPlayerPosY % 2 == 0:
			#currPlayerPosX += 1
		#currPlayerPosY += 1
	#elif Input.is_action_just_pressed("ui_sw"):
		#if currPlayerPosY % 2 != 0:
			#currPlayerPosX -= 1
		#currPlayerPosY += 1
	#elif Input.is_action_just_pressed("ui_w"):
		#currPlayerPosX -= 1



func _check_move_success() -> bool:
	if hexCollisionsNode._player_hit_wall(currPlayerPosX, currPlayerPosY):
		#return back to previous spot (aka) - no movement done this frame.
		currPlayerPosX = prevPlayerPosX
		currPlayerPosY = prevPlayerPosY
		return false
	return true

func _update_player_move() -> void:
	hexGenNode.playerNode.position.x = hexCalculationsNode._hex_pos_x(currPlayerPosX, currPlayerPosY)
	hexGenNode.playerNode.position.y = hexCalculationsNode._hex_pos_y(currPlayerPosX, currPlayerPosY)
