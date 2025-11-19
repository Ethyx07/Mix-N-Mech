extends Node


var bIsDragging = false
var mechPartUnlocked = {
	""
}

func _physics_process(_delta: float) -> void:
	if Input.is_action_pressed("LeftClick"):
		bIsDragging = true
	else:
		bIsDragging = false
