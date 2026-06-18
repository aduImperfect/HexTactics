extends Node2D

@export var hexGenNode : Node2D
@export var hexCalculationsNode : Node2D

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(_delta: float) -> void:
	pass

func _player_hit_wall(_pX : int, _pY : int) -> bool:
	for k in hexGenNode.wallCount:
		if (hexGenNode.wallXArr[k] == _pX) && (hexGenNode.wallYArr[k] == _pY): 
			return true
	return false

func _player_hit_goal(_pX : int, _pY : int) -> bool:
	if (hexGenNode.goalPosX == _pX) && (hexGenNode.goalPosY == _pY): 
		return true
	return false
