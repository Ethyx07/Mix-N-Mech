extends Node


var bIsDragging = false
@export var mechDictionary : Dictionary[MechData, bool]
var unlockedMechs : Array[MechData]
var currentPlayer : Player
var basePlayer = preload("res://Scenes/Player/player.tscn")
var mechPlayer = preload("res://Scenes/Player/mechPlayer.tscn")

func _ready() -> void:
	spawn_player()
	for mechPart in mechDictionary: #Loops through dict of all mech parts and if they are unlocked add to unlocked list
		if mechDictionary[mechPart]:
			unlockedMechs.append(mechPart)

func _physics_process(_delta: float) -> void:
	if Input.is_action_pressed("LeftClick"): #Must already be hovering on actor to left click and drag
		bIsDragging = true
	else:
		bIsDragging = false

func spawn_player() -> void:
	var player = basePlayer.instantiate() #Spawns the initial player type
	add_child(player)
	player.global_position = Vector2(600,600)
	currentPlayer = player #Sets current player so it remains valid whilst player is spawned	

func spawn_mech(mechDataList : Array[MechData]) -> void:
	var player = mechPlayer.instantiate() #Creates the mech instance
	player.mechParts = mechDataList #Sets its data list to the one passed in by the UI
	player.set_mech_parts() #Sets its pieces into their positions
	add_child(player)
	player.scale = Vector2(8,8)
	player.global_position = currentPlayer.global_position
	currentPlayer.queue_free()
	currentPlayer = player
