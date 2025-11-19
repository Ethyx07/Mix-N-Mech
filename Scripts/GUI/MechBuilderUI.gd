extends Node2D

const draggablePart := preload("res://Scenes/GUI/draggableItem.tscn")
@export var partResources : Array[MechData]

func _ready() -> void:
    var numParts = 0
    for mechPart in partResources: #Loads each draggable item instance into the ui, based on how many are unlocked
        var item = draggablePart.instantiate()
        item.mechData = mechPart
        if numParts % 2 != 0:
            item.position = Vector2(400, 20 + (50 * floor(numParts/2)))
        else:
            item.position = Vector2(200, 20 + (50 * floor(numParts/2)))
        numParts += 1
        get_node("ScrollContainer").add_child(item)
