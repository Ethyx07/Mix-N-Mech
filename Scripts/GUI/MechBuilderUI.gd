extends Node2D

const draggablePart := preload("res://Scenes/GUI/draggableItem.tscn")


func _ready() -> void:
	await get_tree().create_timer(1).timeout
	var numParts = 0
	for mechPart in PlayerData.unlockedMechs: #Loads each draggable item instance into the ui, based on how many are unlocked
		var item = draggablePart.instantiate()
		item.mechData = mechPart
		item.update_data()
		if numParts % 2 != 0:
			item.position = Vector2(300, 50 + (50 * floor(numParts/2)))
		else:
			item.position = Vector2(200, 50 + (50 * floor(numParts/2)))
		numParts += 1
		get_node("ScrollContainer/Container").add_child(item)
	
