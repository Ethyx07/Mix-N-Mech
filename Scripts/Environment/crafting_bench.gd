extends Node2D



func _ready() -> void:
	get_node("Control").visible = false


func _on_area_2d_area_entered(area: Area2D) -> void:
	get_node("Control").visible = true


func _on_area_2d_area_exited(area: Area2D) -> void:
	get_node("Control").visible = false
