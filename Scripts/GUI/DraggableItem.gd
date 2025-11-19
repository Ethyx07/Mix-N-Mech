extends Node2D

@export var MechType : GlobalEnums.MechPieces
@export var bUnlocked : bool
var bDraggable : bool = false
var defaultPosition : Vector2
var bCurrentlyDragged : bool = false
var bPlaced : bool = false
var overlappingActors : Array[Area2D]
var mechSelector : Variant
@export var mechData : MechData

func _ready() -> void:
	defaultPosition = global_position #Stores default position of the object
	get_node("Sprite2D").texture = mechData.mechSprite
	get_node("Sprite2D").position = mechData.spriteOffset #Sets mech sprite and its position so it is centered
	get_node("attachmentPoint").position = mechData.attachmentPoint #Sets the attachment point nodes position for attaching sprites

func _physics_process(_delta: float) -> void:
	if bDraggable and bUnlocked: #Must be unlocked and currently draggable
		if Input.is_action_pressed("LeftClick"): #If left click is held, follows mouse
			global_position = get_global_mouse_position()
			bCurrentlyDragged = true
	if Input.is_action_just_released("LeftClick") and bCurrentlyDragged: #Upon release it checks its overlapping actors
		check_overlap()
		

func _on_area_2d_mouse_entered() -> void:
	if !PlayerData.bIsDragging:
		bDraggable = true

func _on_area_2d_mouse_exited() -> void:
	if !bCurrentlyDragged:
		bDraggable = false

func check_overlap() -> void: #If overlapping size != 0, it takes the first overlapping actor and locks the mech piece onto that
	bCurrentlyDragged = false
	if overlappingActors.size() <= 0:
		if mechSelector:
				bPlaced = false
				mechSelector.remove_piece()
				mechSelector = null
		global_position = defaultPosition #If no overlapping actors resets position to default
		return
	
	global_position = overlappingActors[0].global_position
	bPlaced = true
	overlappingActors[0].get_parent().attach_piece(self)
	mechSelector = overlappingActors[0].get_parent()

		
	
func reset_position() -> void:
	global_position = defaultPosition

func _on_area_2d_area_entered(area: Area2D) -> void:
	if area.get_parent().is_in_group("MechSelector") and area.get_parent().MechType == mechData.mechType: #Adds only MechSelector objects to array if they share the same mech type
		overlappingActors.append(area)


func _on_area_2d_area_exited(area: Area2D) -> void:
	if area.get_parent().is_in_group("MechSelector") and area.get_parent().MechType == mechData.mechType: #Removes only MechSelector objects to array if they share the same mech type
		overlappingActors.erase(area)
