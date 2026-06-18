extends Node2D

const GROUND_SCENE = preload("res://TSCN/ground.tscn")
const START_SCENE = preload("res://TSCN/start.tscn")
const GOAL_SCENE = preload("res://TSCN/goal.tscn")
const PLAYER_SCENE = preload("res://TSCN/player.tscn")
const WALL_SCENE = preload("res://TSCN/wall.tscn")
const HOVER_SCENE = preload("res://TSCN/hovering.tscn")

@export var hexCalculationsNode : Node2D

@export var groundArr : Array[Node2D] = []
@export var groundXArr : Array[int] = []
@export var groundYArr : Array[int] = []

@export var wallArr : Array[Node2D] = []
@export var wallXArr : Array[int] = []
@export var wallYArr : Array[int] = []

@export var coinArr : Array[Node2D] = []
@export var coinXArr : Array[int] = []
@export var coinYArr : Array[int] = []

@export var groundNum : int = 0
@export var groundDiv : int = 0

@export var wallMaxNum : int = 0
@export var wallCount : int = 0
@export var wallDiv : int = 0

@export var coinMaxNum : int = 0
@export var coinCount : int = 0
@export var coinDiv : int = 0

@export var startNode : Node2D
@export var startPosX : int = 0
@export var startPosY : int = 0

@export var goalNode : Node2D
@export var goalPosX : int = 0
@export var goalPosY : int = 0

@export var playerNode : Node2D
@export var playerPosX : int = 0
@export var playerPosY : int = 0

@export var hoverNode : Node2D
@export var startHoverPosX : int = 0
@export var startHoverPosY : int = 0

@export var spawnedEverything : bool = false

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	startPosX = 2
	startPosY = 2

	goalPosX = 4
	goalPosY = 16

	playerPosX = 2
	playerPosY = 2

	groundNum = 361
	groundDiv = 19

	wallMaxNum = 361
	wallCount = 0
	wallDiv = 19

	coinMaxNum = 361
	coinCount = 0
	coinDiv = 19
	
	startHoverPosX = -100
	startHoverPosY = -100

	#enemy1MaxNum = 361
	#enemy1Count = 0
	#enemy1Div = 19
#
	#enemy2MaxNum = 361
	#enemy2Count = 0
	#enemy2Div = 19
#
	#enemy3MaxNum = 361
	#enemy3Count = 0
	#enemy3Div = 19

	spawnedEverything = false


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(_delta: float) -> void:

	if spawnedEverything == false:
		_spawn_ground()
		_spawn_start()
		_spawn_goal()
		_spawn_player()
		_spawn_walls()
		_spawn_hovering()
	spawnedEverything = true

func _spawn_ground() -> void:
	var ground_instance
	var _xBegin : int = 1
	var _yBegin : int = 1

	for k in groundNum:
		ground_instance = GROUND_SCENE.instantiate()
		#multiplied decrement by each increase of the yVal.
		#on being even -  make sure to take the lower valued decrement to offset the hex
		ground_instance.global_position.x = hexCalculationsNode._hex_pos_x(_xBegin, _yBegin)
		ground_instance.global_position.y = hexCalculationsNode._hex_pos_y(_xBegin, _yBegin)
		add_child(ground_instance)
		groundArr.append(ground_instance)
		groundXArr.append(_xBegin)
		groundYArr.append(_yBegin)
		#_increment(_xBegin, _yBegin, groundNum, groundDiv)
		_xBegin += 1
		if (_xBegin > int(groundNum / float(groundDiv))):
			_xBegin = 1
			_yBegin += 1

func _spawn_start() -> void:
	var start_instance = START_SCENE.instantiate()
	start_instance.global_position.x = hexCalculationsNode._hex_pos_x(startPosX, startPosY)
	start_instance.global_position.y = hexCalculationsNode._hex_pos_y(startPosX, startPosY)
	add_child(start_instance)
	startNode = start_instance

func _spawn_goal() -> void:
	var goal_instance = GOAL_SCENE.instantiate()
	goal_instance.global_position.x = hexCalculationsNode._hex_pos_x(goalPosX, goalPosY)
	goal_instance.global_position.y = hexCalculationsNode._hex_pos_y(goalPosX, goalPosY)
	add_child(goal_instance)
	goalNode = goal_instance

func _spawn_player() -> void:
	var player_instance = PLAYER_SCENE.instantiate()
	player_instance.global_position.x = hexCalculationsNode._hex_pos_x(playerPosX, playerPosY)
	player_instance.global_position.y = hexCalculationsNode._hex_pos_y(playerPosX, playerPosY)
	add_child(player_instance)
	playerNode = player_instance

func _spawn_walls() -> void:
	var wall_instance
	var _xBegin : int = 1
	var _yBegin : int = 1

	for k in wallMaxNum:
		if _check_if_occupied(_xBegin, _yBegin):
			_xBegin += 1
			if (_xBegin > int(wallMaxNum / float(wallDiv))):
				_xBegin = 1
				_yBegin += 1
			continue

		var makeWallRand : float = randf_range(0.0, 100.0)

		if makeWallRand >= 30.0 && (_xBegin != 1 && _xBegin != groundDiv && _yBegin != 1 && _yBegin != groundDiv):
			_xBegin += 1
			if (_xBegin > int(wallMaxNum / float(wallDiv))):
				_xBegin = 1
				_yBegin += 1
			continue

		wall_instance = WALL_SCENE.instantiate()
		#multiplied decrement by each increase of the yVal.
		#on being even -  make sure to take the lower valued decrement to offset the hex
		wall_instance.global_position.x = hexCalculationsNode._hex_pos_x(_xBegin, _yBegin)
		wall_instance.global_position.y = hexCalculationsNode._hex_pos_y(_xBegin, _yBegin)
		add_child(wall_instance)
		wallArr.append(wall_instance)
		wallXArr.append(_xBegin)
		wallYArr.append(_yBegin)
		wallCount += 1

		_xBegin += 1
		if (_xBegin > int(wallMaxNum / float(wallDiv))):
			_xBegin = 1
			_yBegin += 1

func _spawn_hovering() -> void:
	var hover_instance = HOVER_SCENE.instantiate()
	hover_instance.global_position.x = hexCalculationsNode._hex_pos_x(startHoverPosX, startHoverPosY)
	hover_instance.global_position.y = hexCalculationsNode._hex_pos_y(startHoverPosX, startHoverPosY)
	add_child(hover_instance)
	hoverNode = hover_instance


func _check_if_occupied(_newX : int, _newY : int) -> bool:
		if _check_if_occupied_internal(startPosX, startPosY, _newX, _newY):
			return true
		if _check_if_occupied_internal(goalPosX, goalPosY, _newX, _newY):
			return true
		if _check_if_occupied_internal(playerPosX, playerPosY, _newX, _newY):
			return true
		return false

func _check_if_occupied_internal(_x : int, _y : int, _newX : int, _newY : int) -> bool:
	if (_x == _newX) && (_y == _newY):
		return true
	return false
