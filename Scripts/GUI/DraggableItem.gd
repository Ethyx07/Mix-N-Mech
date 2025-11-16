extends Node2D

@export var MechType : GlobalEnums.MechPieces
@export var bUnlocked : bool
var bDraggable : bool = false
var defaultPosition : Vector2
var bCurrentlyDragged : bool = false
var overlappingActors : Array[Area2D]

func _ready() -> void:
	defaultPosition = global_position #Stores default position of the object

func _physics_process(_delta: float) -> void:
	
	if bDraggable and bUnlocked: #Must be unlocked and currently draggable
		if Input.is_action_pressed("LeftClick"): #If left click is held, follows mouse
			global_position = get_global_mouse_position()
			bCurrentlyDragged = true
	if Input.is_action_just_released("LeftClick"): #Upon release it checks its overlapping actors
		check_overlap()
		

func _on_area_2d_mouse_entered() -> void:
	bDraggable = true

func _on_area_2d_mouse_exited() -> void:
	if !bCurrentlyDragged:
		bDraggable = false

func check_overlap() -> void: #If overlapping size != 0, it takes the first overlapping actor and locks the mech piece onto that
	bCurrentlyDragged = false
	if overlappingActors.size() <= 0:
		global_position = defaultPosition #If no overlapping actors resets position to default
		return
	
	global_position = overlappingActors[0].global_position
	overlappingActors[0].get_parent().attach_piece(self)

		
	


func _on_area_2d_area_entered(area: Area2D) -> void:
	if area.get_parent().is_in_group("MechSelector") and area.get_parent().MechType == MechType: #Adds only MechSelector objects to array if they share the same mech type
		overlappingActors.append(area)


func _on_area_2d_area_exited(area: Area2D) -> void:
	if area.get_parent().is_in_group("MechSelector") and area.get_parent().MechType == MechType: #Removes only MechSelector objects to array if they share the same mech type
		overlappingActors.erase(area)
