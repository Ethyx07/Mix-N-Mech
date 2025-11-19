extends Node


var bIsDragging = false
@export var mechDictionary : Dictionary[MechData, bool]
var unlockedMechs : Array[MechData]

func _ready() -> void:
	for mechPart in mechDictionary:
		if mechDictionary[mechPart]:
			unlockedMechs.append(mechPart)

func _physics_process(_delta: float) -> void:
	if Input.is_action_pressed("LeftClick"): #Must already be hovering on actor to left click and drag
		bIsDragging = true
	else:
		bIsDragging = false
