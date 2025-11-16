extends Node2D

@export var levelLoad : PackedScene

func _on_exit_mouse_entered() -> void:
	get_node("Exit/CollisionShape2D").disabled = true
	print("AY")
	load_area()

func load_area() -> void:
	var nextStage = levelLoad.instantiate()
	
	nextStage.global_position = get_node("Exit/NextStageSpawn").global_position
	get_parent().add_child(nextStage)
