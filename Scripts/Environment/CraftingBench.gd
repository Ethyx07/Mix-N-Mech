extends Node2D

var craftingUI = preload("res://Scenes/GUI/mechBuilderUI.tscn")

func _ready() -> void:
	get_node("Control").visible = false

func _on_area_2d_body_entered(body: Node2D) -> void: #Makes the interact option visible and allows for player interaction
	if body.is_in_group("Player"):
		get_node("Control").visible = true 


func _on_area_2d_body_exited(body: Node2D) -> void: #Hides the interact option and stops player interaction from occuring
	if body.is_in_group("Player"):
		get_node("Control").visible = false

func interact():
	var UI = craftingUI.instantiate()
	get_tree().root.get_node("/root/PlayerData").add_child(UI)
