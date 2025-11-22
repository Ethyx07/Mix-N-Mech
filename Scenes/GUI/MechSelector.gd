extends Node2D

@export var MechType : GlobalEnums.MechPieces
var CurrentEquippedPiece : Variant
var num = 0

func attach_piece(MechPiece : Variant) -> void:
	if CurrentEquippedPiece != null: #If current isnt null, swaps them
		return
	CurrentEquippedPiece = MechPiece
	
func remove_piece() -> void: #Removes piece when no longer on selector
	CurrentEquippedPiece = null


func combine_pieces(bodyPiece : Variant) -> void:
	if CurrentEquippedPiece: #Moves currently equipped piece
		CurrentEquippedPiece.move_to_attach(bodyPiece, bodyPiece.attachmentPoints[CurrentEquippedPiece.MechType])
