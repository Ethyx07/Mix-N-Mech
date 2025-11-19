extends Node


var bIsDragging = false


func _physics_process(_delta: float) -> void:
	if Input.is_action_pressed("LeftClick"): #Must already be hovering on actor to left click and drag
		bIsDragging = true
	else:
		bIsDragging = false
