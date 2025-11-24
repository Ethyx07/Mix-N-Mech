extends Node2D

@export var MechType : GlobalEnums.MechPieces
@export var bUnlocked : bool
var bDraggable : bool = false
var bAttaching : bool = false
var defaultPosition : Vector2
var bCurrentlyDragged : bool = false
var overlappingActors : Array[Area2D]
var mechSelector : Variant
var attachmentOffset : Vector2
var attachmentPoints : Dictionary[GlobalEnums.MechPieces, Vector2]
var attachLocation : Vector2
@export var mechData : MechData

func _ready() -> void:
	defaultPosition = global_position #Stores default position of the object
	
	
func _physics_process(_delta: float) -> void:
	if bDraggable and bUnlocked: #Must be unlocked and currently draggable
		if Input.is_action_pressed("LeftClick"): #If left click is held, follows mouse
			global_position = get_global_mouse_position()
			bCurrentlyDragged = true
	if Input.is_action_just_released("LeftClick") and bCurrentlyDragged: #Upon release it checks its overlapping actors
		check_overlap()
	get_node("Sprite2D").position = attachmentOffset + get_node("attachmentPoint").position #Ensures sprite pos stays relative to attachment pos when mech is built
	
	if bAttaching:
		get_node("attachmentPoint").global_position = attachLocation
		bAttaching = false

func _on_area_2d_mouse_entered() -> void:
	if !PlayerData.bIsDragging: #Makes sure player isnt already dragging something
		bDraggable = true

func _on_area_2d_mouse_exited() -> void:
	if !bCurrentlyDragged:
		bDraggable = false

func check_overlap() -> void: #If overlapping size != 0, it takes the first overlapping actor and locks the mech piece onto that
	bCurrentlyDragged = false
	if overlappingActors.size() <= 0:
		if mechSelector:
				mechSelector.remove_piece()
				mechSelector = null
		global_position = defaultPosition #If no overlapping actors resets position to default
		return
	global_position = overlappingActors[0].global_position
	overlappingActors[0].get_parent().attach_piece(self)
	mechSelector = overlappingActors[0].get_parent()

func update_data() -> void:
	get_node("Sprite2D").texture = mechData.mechSprite
	get_node("Sprite2D").position = mechData.spriteOffset #Sets mech sprite and its position so it is centered
	get_node("attachmentPoint").position = mechData.attachmentPoint #Sets the attachment point nodes position for attaching sprites
	self.name = mechData.mechName
	MechType = mechData.mechType
	if mechData.mechType == GlobalEnums.MechPieces.BODY: #Sets up attachment points for Body pieces
		attachmentPoints = mechData.attachmentDict
		self.z_index = 2 #Sets index to 2 so its in front of right arm but behind the rest
		set_attachment_nodes()
	elif  mechData.mechType == GlobalEnums.MechPieces.RARM:
		self.z_index = 1 #Should be behind the rest of the mech pieces
	else:
		self.z_index = 3 #The rest are at the front view
	attachmentOffset = mechData.spriteOffset - mechData.attachmentPoint #Finds the difference in position between the two

func set_attachment_nodes()	-> void:
	for attachPoint in attachmentPoints:
		var node = Marker2D.new() #Creates the attachment points at the local positions only for the body
		add_child(node)
		node.position = attachmentPoints[attachPoint]
	
func reset_position() -> void:
	global_position = defaultPosition

func _on_area_2d_area_entered(area: Area2D) -> void:
	if area.get_parent().is_in_group("MechSelector") and area.get_parent().MechType == mechData.mechType: #Adds only MechSelector objects to array if they share the same mech type
		overlappingActors.append(area)


func _on_area_2d_area_exited(area: Area2D) -> void:
	if area.get_parent().is_in_group("MechSelector") and area.get_parent().MechType == mechData.mechType: #Removes only MechSelector objects to array if they share the same mech type
		overlappingActors.erase(area)


func move_to_attach(body : Variant , point : Vector2):
	bAttaching = true
	attachLocation = body.to_global(point) #Gets attachment locations global position relative to the body
