extends Node2D

@export var MechType : GlobalEnums.MechPieces
var CurrentEquippedPiece : Variant

func attach_piece(MechPiece : Variant) -> void:
	if CurrentEquippedPiece != null:
		return
	CurrentEquippedPiece = MechPiece
	
func remove_piece() -> void:
	CurrentEquippedPiece = null
