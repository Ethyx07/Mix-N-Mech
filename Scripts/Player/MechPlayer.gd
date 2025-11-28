extends Player

var mechParts : Array[MechData]
var bodyNode : Node2D

func _ready() -> void:
	super()
	

func setup_attachments (attachmentPoints : Dictionary[GlobalEnums.MechPieces, Vector2], mechPart : MechData) -> void:
	bodyNode = get_node("BODY")
	for attachPoint in attachmentPoints:
		var node = Marker2D.new() #Creates the attachment points at the local positions only for the body
		bodyNode.add_child(node)
		node.position = attachmentPoints[attachPoint] - mechPart.spriteOffset
		node.name = GlobalEnums.MechPieces.find_key(attachPoint)

func set_mech_parts() -> void:
	for mechPart in mechParts:
		update_part(mechPart)
		
func update_part(mechPart : MechData) -> void:
	var stringDIR = GlobalEnums.MechPieces.find_key(mechPart.mechType)
	var currentPart = get_node(stringDIR)
	currentPart.texture = mechPart.mechSprite #Sets details of current sprite including its texture and attachments
	if stringDIR == "BODY":
		setup_attachments(mechPart.attachmentDict, mechPart)
	else:
		attach_node(stringDIR, mechPart)
	
	#print(stringDIR)
	
func attach_node(dir : String, mechData : MechData) -> void:
	var nodeMarker = Marker2D.new() #Creates a marker that will align with the marker used on the body
	get_node(dir).add_child(nodeMarker)
	nodeMarker.name = dir + " Attachment"
	nodeMarker.position = mechData.mechAttachOffset #Sets markers offset value so when its moved the sprite can move too
	var nodeOffset = get_node(dir).position - nodeMarker.position 
	get_node(dir).position = get_node("BODY/" + dir).position + nodeOffset #sets position of sprite to be the attachment point + the offset
