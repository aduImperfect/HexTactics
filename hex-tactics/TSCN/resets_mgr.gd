extends Node2D

@export var hexGenNode : Node2D
@export var hexCalculationsNode : Node2D


# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(_delta: float) -> void:
	pass

func _reset_selection_pos() -> void:
	hexGenNode.selectionNode.position.x = hexCalculationsNode._hex_pos_x(hexGenNode.startSelectionPosX, hexGenNode.startSelectionPosY)
	hexGenNode.selectionNode.position.y = hexCalculationsNode._hex_pos_y(hexGenNode.startSelectionPosX, hexGenNode.startSelectionPosY)

func _reset_alt_selection_pos() -> void:
	hexGenNode.altSelectionNode.position.x = hexCalculationsNode._hex_pos_x(hexGenNode.startAltSelectionPosX, hexGenNode.startAltSelectionPosY)
	hexGenNode.altSelectionNode.position.y = hexCalculationsNode._hex_pos_y(hexGenNode.startAltSelectionPosX, hexGenNode.startAltSelectionPosY)

func _reset_path() -> void:
	for path in hexGenNode.pathArr:
		path.position.x = hexCalculationsNode._hex_pos_x(hexGenNode.startPathPosX, hexGenNode.startPathPosY)
		path.position.y = hexCalculationsNode._hex_pos_y(hexGenNode.startPathPosX, hexGenNode.startPathPosY)
