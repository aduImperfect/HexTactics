extends Node2D

const GROUND_SCENE = preload("res://TSCN/ground.tscn")
const START_SCENE = preload("res://TSCN/start.tscn")
const GOAL_SCENE = preload("res://TSCN/goal.tscn")
const PLAYER_SCENE = preload("res://TSCN/player.tscn")
const WALL_SCENE = preload("res://TSCN/wall.tscn")
const HOVER_SCENE = preload("res://TSCN/hovering.tscn")
const SELECTION_SCENE = preload("res://TSCN/clicked1.tscn")
const ALTSELECTION_SCENE = preload("res://TSCN/clicked2.tscn")
const PATH_SCENE = preload("res://TSCN/path.tscn")
const MOVED_SCENE = preload("res://TSCN/moved.tscn")
const TEAM1AOE_SCENE = preload("res://TSCN/team1aoe.tscn")
const TEAM2AOE_SCENE = preload("res://TSCN/team2aoe.tscn")
const TEAM1ARCHER_SCENE = preload("res://TSCN/team1archer.tscn")
const TEAM2ARCHER_SCENE = preload("res://TSCN/team2archer.tscn")
const TEAM1MELEE_SCENE = preload("res://TSCN/team1melee.tscn")
const TEAM2MELEE_SCENE = preload("res://TSCN/team2melee.tscn")

@export var hexCalculationsNode : Node2D

@export var pathArr : Array[Node2D] = []
@export var pathXArr : Array[int] = []
@export var pathYArr : Array[int] = []
@export var startPathPosX : int = 0
@export var startPathPosY : int = 0

@export var movedArr : Array[Node2D] = []
@export var movedXArr : Array[int] = []
@export var movedYArr : Array[int] = []
@export var startMovedPosX : int = 0
@export var startMovedPosY : int = 0

@export var groundArr : Array[Node2D] = []
@export var groundXArr : Array[int] = []
@export var groundYArr : Array[int] = []

@export var groundXWinArr : Array[float] = []
@export var groundYWinArr : Array[float] = []

@export var wallArr : Array[Node2D] = []
@export var wallXArr : Array[int] = []
@export var wallYArr : Array[int] = []

@export var coinArr : Array[Node2D] = []
@export var coinXArr : Array[int] = []
@export var coinYArr : Array[int] = []

@export var pathMaxNum : int = 0
@export var movedMaxNum : int = 0

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

@export var team1AOENode : Node2D
@export var team1AOEPosX : int = 0
@export var team1AOEPosY : int = 0

@export var team2AOENode : Node2D
@export var team2AOEPosX : int = 0
@export var team2AOEPosY : int = 0

@export var team1ArcherNode : Node2D
@export var team1ArcherPosX : int = 0
@export var team1ArcherPosY : int = 0

@export var team2ArcherNode : Node2D
@export var team2ArcherPosX : int = 0
@export var team2ArcherPosY : int = 0

@export var team1MeleeNode : Node2D
@export var team1MeleePosX : int = 0
@export var team1MeleePosY : int = 0

@export var team2MeleeNode : Node2D
@export var team2MeleePosX : int = 0
@export var team2MeleePosY : int = 0

@export var hoverNode : Node2D
@export var startHoverPosX : int = 0
@export var startHoverPosY : int = 0
@export var currentHoverPosX : int = 0
@export var currentHoverPosY : int = 0

@export var selectionNode : Node2D
@export var startSelectionPosX : int = 0
@export var startSelectionPosY : int = 0
@export var currentSelectionPosX : int = 0
@export var currentSelectionPosY : int = 0

@export var altSelectionNode : Node2D
@export var startAltSelectionPosX : int = 0
@export var startAltSelectionPosY : int = 0
@export var currentAltSelectionPosX : int = 0
@export var currentAltSelectionPosY : int = 0

@export var spawnedEverything : bool = false

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	startPosX = -100
	startPosY = -100

	goalPosX = -100
	goalPosY = -100

	playerPosX = -100
	playerPosY = -100

	team1AOEPosX = 2
	team1AOEPosY = 2

	team2AOEPosX = 18
	team2AOEPosY = 2

	team1ArcherPosX = 3
	team1ArcherPosY = 10

	team2ArcherPosX = 17
	team2ArcherPosY = 10

	team1MeleePosX = 2
	team1MeleePosY = 18

	team2MeleePosX = 18
	team2MeleePosY = 18

	groundNum = 361
	groundDiv = 19

	wallMaxNum = 361
	wallCount = 0
	wallDiv = 19

	coinMaxNum = 361
	coinCount = 0
	coinDiv = 19

	pathMaxNum = 10
	movedMaxNum = 10

	startHoverPosX = -100
	startHoverPosY = -100
	currentHoverPosX = -100
	currentHoverPosY = -100

	startSelectionPosX = -100
	startSelectionPosY = -100
	currentSelectionPosX = -100
	currentSelectionPosY = -100

	startAltSelectionPosX = -100
	startAltSelectionPosY = -100
	currentAltSelectionPosX = -100
	currentAltSelectionPosY = -100

	startPathPosX = -100
	startPathPosY = -100

	startMovedPosX = -100
	startMovedPosY = -100

	spawnedEverything = false


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(_delta: float) -> void:

	if spawnedEverything == false:
		_spawn_ground()
		_spawn_start()
		_spawn_goal()
		_spawn_player()
		_spawn_team1aoe()
		_spawn_team2aoe()
		_spawn_team1archer()
		_spawn_team2archer()
		_spawn_team1melee()
		_spawn_team2melee()
		#_spawn_walls()
		_spawn_hovering()
		_spawn_selection()
		_spawn_alt_selection()
		_spawn_path()
		_spawn_moved()
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
		groundXWinArr.append(ground_instance.global_position.x)
		groundYWinArr.append(ground_instance.global_position.y)
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

func _spawn_team1aoe() -> void:
	var team1aoe_instance = TEAM1AOE_SCENE.instantiate()
	team1aoe_instance.global_position.x = hexCalculationsNode._hex_pos_x(team1AOEPosX, team1AOEPosY)
	team1aoe_instance.global_position.y = hexCalculationsNode._hex_pos_y(team1AOEPosX, team1AOEPosY)
	add_child(team1aoe_instance)
	team1AOENode = team1aoe_instance

func _spawn_team2aoe() -> void:
	var team2aoe_instance = TEAM2AOE_SCENE.instantiate()
	team2aoe_instance.global_position.x = hexCalculationsNode._hex_pos_x(team2AOEPosX, team2AOEPosY)
	team2aoe_instance.global_position.y = hexCalculationsNode._hex_pos_y(team2AOEPosX, team2AOEPosY)
	add_child(team2aoe_instance)
	team2AOENode = team2aoe_instance

func _spawn_team1archer() -> void:
	var team1archer_instance = TEAM1ARCHER_SCENE.instantiate()
	team1archer_instance.global_position.x = hexCalculationsNode._hex_pos_x(team1ArcherPosX, team1ArcherPosY)
	team1archer_instance.global_position.y = hexCalculationsNode._hex_pos_y(team1ArcherPosX, team1ArcherPosY)
	add_child(team1archer_instance)
	team1ArcherNode = team1archer_instance

func _spawn_team2archer() -> void:
	var team2archer_instance = TEAM2ARCHER_SCENE.instantiate()
	team2archer_instance.global_position.x = hexCalculationsNode._hex_pos_x(team2ArcherPosX, team2ArcherPosY)
	team2archer_instance.global_position.y = hexCalculationsNode._hex_pos_y(team2ArcherPosX, team2ArcherPosY)
	add_child(team2archer_instance)
	team2ArcherNode = team2archer_instance

func _spawn_team1melee() -> void:
	var team1melee_instance = TEAM1MELEE_SCENE.instantiate()
	team1melee_instance.global_position.x = hexCalculationsNode._hex_pos_x(team1MeleePosX, team1MeleePosY)
	team1melee_instance.global_position.y = hexCalculationsNode._hex_pos_y(team1MeleePosX, team1MeleePosY)
	add_child(team1melee_instance)
	team1MeleeNode = team1melee_instance

func _spawn_team2melee() -> void:
	var team2melee_instance = TEAM2MELEE_SCENE.instantiate()
	team2melee_instance.global_position.x = hexCalculationsNode._hex_pos_x(team2MeleePosX, team2MeleePosY)
	team2melee_instance.global_position.y = hexCalculationsNode._hex_pos_y(team2MeleePosX, team2MeleePosY)
	add_child(team2melee_instance)
	team2MeleeNode = team2melee_instance


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

func _spawn_selection() -> void:
	var selection_instance = SELECTION_SCENE.instantiate()
	selection_instance.global_position.x = hexCalculationsNode._hex_pos_x(startSelectionPosX, startSelectionPosY)
	selection_instance.global_position.y = hexCalculationsNode._hex_pos_y(startSelectionPosX, startSelectionPosY)
	add_child(selection_instance)
	selectionNode = selection_instance

func _spawn_alt_selection() -> void:
	var altselection_instance = ALTSELECTION_SCENE.instantiate()
	altselection_instance.global_position.x = hexCalculationsNode._hex_pos_x(startAltSelectionPosX, startAltSelectionPosY)
	altselection_instance.global_position.y = hexCalculationsNode._hex_pos_y(startAltSelectionPosX, startAltSelectionPosY)
	add_child(altselection_instance)
	altSelectionNode = altselection_instance

func _spawn_path() -> void:
	var path_instance

	for k in pathMaxNum:
		path_instance = PATH_SCENE.instantiate()
		path_instance.global_position.x = hexCalculationsNode._hex_pos_x(startPathPosX, startPathPosY)
		path_instance.global_position.y = hexCalculationsNode._hex_pos_y(startPathPosX, startPathPosY)
		add_child(path_instance)
		pathArr.append(path_instance)
		pathXArr.append(startPathPosX)
		pathYArr.append(startPathPosY)

func _spawn_moved() -> void:
	var moved_instance

	for k in pathMaxNum:
		moved_instance = MOVED_SCENE.instantiate()
		moved_instance.global_position.x = hexCalculationsNode._hex_pos_x(startMovedPosX, startMovedPosY)
		moved_instance.global_position.y = hexCalculationsNode._hex_pos_y(startMovedPosX, startMovedPosY)
		add_child(moved_instance)
		movedArr.append(moved_instance)
		movedXArr.append(startMovedPosX)
		movedYArr.append(startMovedPosY)


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
