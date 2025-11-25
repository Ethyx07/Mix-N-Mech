extends Node2D

const draggablePart := preload("res://Scenes/GUI/draggableItem.tscn")
var mechSelectorList : Dictionary[String, Variant]

func _ready() -> void:
	var mechSelectors = get_tree().get_nodes_in_group("MechSelector")
	for mechSelect in mechSelectors: #Stores the mech selectors in the ui
		mechSelectorList[mechSelect.name] = mechSelect
	await get_tree().create_timer(1).timeout
	var numParts = 0
	for mechPart in PlayerData.unlockedMechs: #Loads each draggable item instance into the ui, based on how many are unlocked
		var item = draggablePart.instantiate()
		item.mechData = mechPart
		item.builderZIndex = z_index
		item.update_data()
		if numParts % 2 != 0: #Moves pieces next to each other side by side and vertically to make a 2xHeight
			@warning_ignore("integer_division") #Ignoring as its intended to remove the decimal either way
			item.position = Vector2(150, 25 + (50 * floor(numParts/2)))
		else:
			@warning_ignore("integer_division")
			item.position = Vector2(50, 25 + (50 * floor(numParts/2)))
		numParts += 1
		get_node("ScrollContainer/Container").add_child(item)

func _physics_process(_delta: float) -> void:
	update_button()

func _on_button_pressed() -> void:
	for mechSelector in mechSelectorList:
		if mechSelector != "Body": #Body gets ignored as all pieces combine onto it
			mechSelectorList[mechSelector].combine_pieces(mechSelectorList["Body"].CurrentEquippedPiece)
	await get_tree().create_timer(3).timeout
	get_tree().get_first_node_in_group("Player").clear_interact()
	self.queue_free()

func update_button() -> void:
	var bDisabled = false #Loops through all mechSelectors and if any are null button is deactivated
	for mechSelector in mechSelectorList: #Loops through all mech selectors
		if !bDisabled:
			if mechSelectorList[mechSelector].CurrentEquippedPiece == null: #Any null disabled becomes true
				bDisabled = true
	get_node("Control/Button").disabled = bDisabled
