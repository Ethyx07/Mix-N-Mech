extends Node2D

@export var MechType : GlobalEnums.MechPieces
var CurrentEquippedPiece : Variant

func attach_piece(MechPiece : Variant) -> void:
	if CurrentEquippedPiece != null: #If current isnt null, swaps them
		return
	CurrentEquippedPiece = MechPiece
	
func remove_piece() -> void:
	CurrentEquippedPiece = null
