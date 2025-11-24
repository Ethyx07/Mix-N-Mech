extends CharacterBody2D

var inputVector : Vector2
var speed : float = 250
var bInteracting = false
var interactBox : Area2D

func _ready() -> void:
	interactBox = get_node("Area2D")

func _physics_process(_delta: float) -> void:
	if !bInteracting: #Using a function instead of coding it into the physics to try and keep it neater
		player_move()
		if Input.is_action_just_pressed("Interact"):
			interact()

func player_move() -> void: #Sets input vector to zero and then chechs input strength to determine where to move
	inputVector = Vector2.ZERO
	inputVector.x = Input.get_action_strength("Right") - Input.get_action_strength("Left")
	inputVector.y = Input.get_action_strength("Down") - Input.get_action_strength("Up")
	
	velocity = inputVector * speed
	move_and_slide()	

func interact() -> void:
	var overlappingActors = interactBox.get_overlapping_areas() #Gets all overlapping bodies
	if overlappingActors.size() > 0: #Ensures there are at least 1
		var currDistance = 9999
		var targetInteractor
		for actor in overlappingActors: #Loops through all and selects the one closest to the player
			var tempDistance = actor.global_position.distance_to(global_position)
			if tempDistance < currDistance:
				currDistance = tempDistance
				targetInteractor = actor
		targetInteractor.get_parent().interact()
		bInteracting = true
		
func clear_interact() -> void:
	bInteracting = false		
